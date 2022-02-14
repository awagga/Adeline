:NameSpace D20
dice   ← ,'d'
number ← ,'0123456789'
plus   ← ,'+'
minus  ← ,'-'

P  ← ⊣⊂⍨1,2≠/⊢

Infix   ← { 
    l   ← ⍺∘≡¨⍵
    idx ← 1(-⍨,+)⍸l
    ri  ← 1@idx⊢l
    ri≢0:⊃,/⍺⍺¨@{∧/¨P⍨ri} ⍵ P ri⋄⍵
}

Roll ← {
    R  ← number (⊢P∊⍨) ' '~⍨⍵
    R  ←   dice {⊆∊'(+/?'(⊣/⍵)'⍴'(⊢/⍵)')'} Infix R
                         ⊃⊃{⊆∊'('(,/⍵)')'} Infix/minus plus R
}
:EndNameSpace

