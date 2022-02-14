⎕CY 'salt'
⎕FIX'file://d20.apl'
_ ← enableSALT 
_ ← ⎕SE.UCMD'Box -trains=tree -style=max on'

Convert ← ⎕UCS∘⎕UCS

{ ⍳11::⎕FMT(⎕DMX.(EM Message)) ⋄ ⍎ 'UTF-8' Convert ⊃(⊣,' ',⊢)/ 3↓2⎕NQ#'GetCommandLineArgs' } ⍬
