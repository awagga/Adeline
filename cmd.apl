:NameSpace Command

U ← {⍺←⊢ ⋄ (⍵⍵⍣¯1)⍺(⍺⍺⍥⍵⍵)⍵}
O ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}
V ← {⍺←⊢ ⋄ ⍺(⍺⍺⍤¯1 0 99)⍵}
R ← ≢⍤⊢↑⍪

⍝ Indicate tail of booleans
T ← ∧\U⌽

Format ← {
  tokens ← (0 1 0)(0 1 1 0)(0 1 1 1 0)
  mask   ← '`'=⍵

  Pad  ← (,∘0)0∘,
  Find ← ⊃O⍷V   ⍝ Rows reflect appearance of each token sequence

  Pair ← (T≠\)O<             ⍝ Balance appearances
  Leap ← ∨⌿U(≠\)             ⍝ Turn off 1s inside cross-section(s) of other tokens
  Real ← ∧∘(∨⌿¯1 ¯2 ¯3⌽V⊢)   ⍝ Replace remaining 1s with original sequences; Find⍣¯1

  ⍝ Represent code-blocks as nested vector
  ⍵ ⊆⍨ ~(⊢ Real∘Leap∘Pair tokens∘Find)U(Pad)mask 
}

Parse ← {
  ⍝ Indicate characters after prefix
  Mark ← (⊃ ∧∘T 0=(1↑⍨1-≢⍺)∘R)(<\⍺∘⍷)

  (⊂'')~⍨ ((⍸Mark)⌷V⊢)¨⍵   ⍝ Selects indicated characters - removing N/A blocks;
}

⍝ Recieves a possibly formatted command, returns APL-strings (to be executed).
Handle ← 'dyalog)' Parse Format

:EndNameSpace