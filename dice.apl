:NameSpace Dice

⎕IO ← 0

P  ← ⊣⊂⍨1,2≠/⊢
F  ← ⊃ ⊣/
L  ← ⊃ ⊢/

_I ← { 
    l ← ⍵∊⊂⍺
    l[(≢⌊1(-,+)⍨⍸)l] ← 1
    l≡0:⍵
    ⊃,/⍺⍺@{∧/¨P l}⍵ P l
}

Parse  ← {
    r  ← (⍵~' ') (⊣P∊) '0123456789'
    
    r {w ← ⊃⍵ ⋄ ⊂,/'(1⊥?'(F w)'⍴'(L w)')'}_I⍨∘, 'O'
}

:EndNameSpace
