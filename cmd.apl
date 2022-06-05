:NameSpace Command

Ⓤ ← {⍺←⊢ ⋄ (⍵⍵⍣¯1)⍺(⍺⍺⍥⍵⍵)⍵}
Ⓞ ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}
⍙ ← {⍺←⊢ ⋄ ⍺(⍺⍺⍤¯1 0 99)⍵}
Ⓡ ← ≢⍤⊢↑⍪

⍝ Indicate tail of booleans
Ⓣ ← ∧\Ⓤ⌽

Format ← {
  tokens ← (0 1 0)(0 1 1 0)(0 1 1 1 0)
  mask   ← '`'=⍵

  Pad  ← (,∘0)0∘,
  Find ← ⊃Ⓞ⍷⍙   ⍝ Rows reflect appearance of each token sequence

  Pair ← (Ⓣ≠\)Ⓞ<             ⍝ Balance appearances
  Leap ← ∨⌿Ⓤ(≠\)             ⍝ Turn off 1s inside cross-section(s) of other tokens
  Real ← ∧∘(∨⌿¯1 ¯2 ¯3⌽⍙⊢)   ⍝ Replace remaining 1s with original sequences; Find⍣¯1

  ⍝ Represent code-blocks as nested vector
  ⍵ ⊆⍨ ~(⊢ Real∘Leap∘Pair tokens∘Find)Ⓤ(Pad)mask 
}

Parse ← {
  n←≢⍺

  ⍝ Indicate characters after prefix
  Mark ← (⊃ ∧∘Ⓣ 0=(n↑1)∘Ⓡ)(<\⍺∘⍷)
  
  ⍺,⍥⊂((⍸Mark)⌷⍙⊢)⍵   ⍝ Selects indicated characters
}

prefixes ← 'i)' 'dyalog)'

⍝ Recieves a formatted command, returns JSON repr of tagged (possibly empty) language-strings.
Handle ← {⎕JSON ⊃,/ prefixes∘(⊃Ⓞ(⊂Parse)⍙) ¨ Format ⍵}

:EndNameSpace