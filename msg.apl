:NameSpace Msg

Ⓤ ← {⍺←⊢ ⋄ (⍵⍵⍣¯1)⍺(⍺⍺⍥⍵⍵)⍵}
Ⓞ ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}


Baln ← (∧\Ⓤ⌽≠\)Ⓞ<


Format ← { 
  Srnd ← (,∘0)0,⊢
  tkns ← (0 1 0)(0 1 1 0)(0 1 1 1 0)
  locs ← ('`'∘=)⍵
  mask ← {⍵ ∧ ⊃∨/, ¯1 ¯2 ¯3 ∘.⌽ tkns (Baln ⍷)¨ ⊂⍵}Ⓤ(Srnd) locs
  ⍵ ⊆⍨ 0 = mask
}

Trim  ← {⍵/⍨2∨/0,⍨' '≠⍵}

Parse ← {
  n←≢d←'dyalog)'
  v ← ⊃,/{⍵ ⊂⍨(>\m)∧(⊢∨≢↑(n↑1),⊢)m ← d ⍷ ⍵}¨⍵
  v /⍨ ¯1 ⌽ d ⊂Ⓞ⍷ v 
}

Handle ← 1 ⎕JSON Parse⍤Format

:EndNameSpace 