:NameSpace dice
⎕IO ← 0

P  ← ⊣⊂⍨1,2≠/⊢

_I ← { 
    l ← ⍵∊⊂⍺
    l[(≢⌊1(-,+)⍨⍸)l] ← 1
    l≡0:⍵
    ⊃,/⍺⍺@{∪¨P l}⍵ P l
}

F ← ⊃ ⊣/
L ← ⊃ ⊢/

⍝ Doesn't handle parentheses
Parse  ← {
    r  ← (⍵~' ') (⊣P∊) '0123456789'
    
    r {w ← ⊃⍵ ⋄ ⊂,/'(1⊥?'(F w)'⍴'(L w)')'}_I⍨∘, 'O'
}

⍝ Dice.Parse '1O20 + 1'
⍝ ┌─────────┬─┬─┐
⍝ │(+/?1⍴20)│+│1│
⍝ └─────────┴─┴─┘

:EndNameSpace
