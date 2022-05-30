:NameSpace Msg

Ⓤ ← {⍺←⊢ ⋄ (⍵⍵⍣¯1)⍺(⍺⍺⍥⍵⍵)⍵} ⍝ ⍢
Ⓞ ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}     ⍝ ⍛

Format ← {
  tkns ← (0 1 0)(0 1 1 0)(0 1 1 1 0) ⍝ Mono, duo, triple back-ticks

  Baln ← (∧\Ⓤ⌽≠\)Ⓞ<    ⍝ Balance booleans
  Srnd ← (,∘0)0,⊢      ⍝ Pad with 0s
  Mask ← '`'∘=
  Find ← ⊃Ⓞ⍷⍤0 1       ⍝ Rows reflect appearance of each token

  Hrcy ← ∨⌿∧(=⌿≠\Ⓞ∨)                ⍝ Hierarchy of tokens
  Orig ← ∧∘(¯1 ¯2 ¯3 (∨⌿⌽⍤0 1) ⊢)   ⍝ Find⍣¯1; replace 1s with corresponding token

  (~ {⍵ Orig Hrcy Baln tkns Find ⍵}Ⓤ Srnd⍤Mask)Ⓞ⊆ ⍵
}

⍝ Baln 1 1   → 1 1
⍝ Baln 1 1 1 → 1 1 0

Parse ← {
  n←≢d←'dyalog)'
  v ← ⊃,/{⍵ ⊂⍨(>\m)∧(⊢∨≢↑(n↑1),⊢)m ← d ⍷ ⍵}¨⍵
  v /⍨ ¯1 ⌽ d ⊂Ⓞ⍷ v 
}

Handle ← 1 ⎕JSON Parse∘Format

:EndNameSpace