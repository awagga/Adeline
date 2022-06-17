:NameSpace Command

Ⓤ ← {⍺←⊢ ⋄ (⍵⍵⍣¯1)⍺(⍺⍺⍥⍵⍵)⍵}
Ⓞ ← {⍺←⊢ ⋄ ((⍺⍺ ⍺)⍵⍵⊢)⍵}
⍙ ← {⍺←⊢ ⋄ ⍺(⍺⍺⍤¯1 0 99)⍵}
Ⓡ ← ≢⍤⊢↑⍪
Ⓟ ← ≠⍀∨⊢
Ⓕ ← ⊃,/

⍝ Indicate tail of boolean array
Ⓣ ← ∧\Ⓤ⌽

Format ← {
  tokens ← (0 1 0)(0 1 1 0)(0 1 1 1 0)
  mask   ← '`'=⍵

  Pad  ← (,∘0)0∘,
  Find ← ⊃Ⓞ⍷⍙   ⍝ Rows reflect appearance of each token sequence

  Pair ← ⊢>∘Ⓣ≠\              ⍝ Balance appearances
  Leap ← ∨⌿Ⓤ(≠\)             ⍝ Turn off 1s inside cross-section(s) of other tokens
  Real ← ∧∘(∨⌿¯1 ¯2 ¯3⌽⍙⊢)   ⍝ Replace remaining 1s with original sequences; Find⍣¯1

  ⍝ Represent code-blocks as nested vector
  ⍵ ⊆⍨ ~(⊢ Real∘Leap∘Pair tokens∘Find)Ⓤ(Pad)mask 
}

⍝ Indicate characters after prefix
Mark ← {
  n ← ≢⍺
  (⊃ ∧∘Ⓣ 0=(1↑⍨n-1)∘Ⓡ)<\⍺⍷⍵
}

Rmv ← {
  n ← ≢⍺
  ⍵/⍨0=Ⓟ(⊢∨(0⍴⍨n-1)∘Ⓡ)<\⍺⍷⍵
}

Split ← ≠⊆⊢

_UCMD ← {w ← ⍵⊂⍨≠⍺Mark⍵,' ' ⋄ ⍺≡⊃w: ⍺ ⍺⍺ ⊃⊢/w ⋄ ⍵}

Trim ← {(∨\' '≠⍵)/⍵}

Lit ← ''''∘{⍺∘,,∘⍺ Ⓕ 6⍴¨@(⍺∘=)⍵}

U∆Help    ← ']help'    {Ⓕ⍵,⍨1↓⍺}_UCMD Trim
U∆Display ← ']display' {Ⓕ⍵,⍨1↓⍺}_UCMD Trim
U∆Explain ← ']explain' {Ⓕ 1↓,' ',⍪ ((1⊥'-dyadic'⍷⍵)⍴'2') (1↓⍺) (Lit '-dyadic' Rmv ⍵) }_UCMD Trim

Parse ← { U∆Display∘U∆Help∘U∆Explain¨⊆((⍸⍺∘Mark)⌷⍙⊢)¨⍵ }

⍝ Recieves a possibly formatted command, returns APL-strings (to be executed).
Handle ← 'dyalog)' Parse Format

:EndNameSpace