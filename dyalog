#!/usr/local/bin/dyalogscript
Ï ← ⎕FIX'file://',⊢

Ï 'Safe.dyalog' ⋄ Ï 'cmd.apl' ⋄ 'display'⎕cy'dfns'

Ⓞ ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}

∇ r ← Run expr;ns

    ns ← ⎕NS ⍬
    ns.display ← display
    
    :Trap 0
        r←5 ns Safe.Exec expr
    :Case 6
        r←'Shy'
    :Case 10
        r←'EXPRESSION TIME LIMIT EXCEEDED: Must complete within 5 seconds'
    :Case 11
        r←'Illegal Token'
    :Else
        r←⎕DMX.(Message{⍵,⍺,⍨': '/⍨×≢⍺}⎕EM 200|EN-200)
    :EndTrap
    
    :If 0=×/⍴r ⋄ r ← 'Empty' ⋄ :EndIf
∇

Shrink ← { 
    w ← ⊃,/⍵
    m ← ≢¨⍵
    o ← 1997(⊣-+.>)+\1,m
    o>≢w:⍵
    r ← w⊆⍨(≢w)↑o↑⍸m
    r,⊂'```'
}

⎕ ← 1 ⎕JSON Shrink ⊃,/(⍬ ,⍨⍥('```'⊂Ⓞ,⊢)∘↓ ⎕FMT⍤Run)¨ ⍎ 2 ⎕NQ # 'GetEnvironment',⊂'expr'