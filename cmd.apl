:NameSpace Command

Ⓤ ← {⍺←⊢ ⋄ (⍵⍵⍣¯1)⍺(⍺⍺⍥⍵⍵)⍵}
Ⓞ ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}
⍙ ← {⍺←⊢ ⋄ ⍺(⍺⍺⍤¯1 0 99)⍵}
Ⓡ ← ≢⍤⊢↑⍪

Ⓣ ← ∧\Ⓤ⌽

Format ← {
  tok  ← (0 1 0)(0 1 1 0)(0 1 1 1 0)
  mask ← '`'=⍵

  Pair ← (Ⓣ≠\)Ⓞ<    ⍝ Balance booleans
  Pad  ← (,∘0)0,⊢
  Find ← ⊃Ⓞ⍷⍙       ⍝ Rows reflect appearance of each token
  Leap ← ∨⌿Ⓤ(≠\)    ⍝ Turn off 1s inside cross-section(s)

  Real ← ∧∘(∨⌿¯1 ¯2 ¯3⌽⍙⊢) ⍝ Replace 1s with original trailing sequences

  ↑⍵ ⊆⍨ ~(⊢ Real∘Leap∘Pair tok∘Find)Ⓤ(Pad)mask
}

Parse ← {
  n←≢prfx←⍺
  masks ← (⊃ ∧∘Ⓣ∘~ (n↑1)∘Ⓡ)⍙(<\prfx∘⍷)⍵
  ⍵ ⊆⍨⍥, masks 
}

Handle ← ⎕JSON 'dyalog)' Parse Format

:EndNameSpace