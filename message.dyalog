:NameSpace Message
'display'⎕cy'dfns'

Ⓤ ← {⍺←⊢ ⋄ f←⍺⍺ ⋄ g←⍵⍵ ⋄ ⍺(g⍣¯1 f⍥g)⍵}
⍙ ← {⍺←⊢ ⋄ ⍺(⍺⍺⍤¯1 0 99 )⍵}
Ⓡ ← ≢⍤⊢↑⍪

Trim  ← {(∨\' '≠⍵)/⍵}

Ⓣ ← ∧\Ⓤ⌽   ⍝ Indicate tail of boolean array
Ⓟ ← =\Ⓤ⌽

Format ← {
  tokens ← ,¨'`' '``' '```'

  Part ← ⊢⊂⍨1,2≠/⊢
  Pair ← ⊢>∘Ⓣ≠\             ⍝ Balance immediate appearances
  Leap ← ∨⌿Ⓤ(≠\)            ⍝ Turn off 1s inside cross-section(s) of other tokens

  ⍵ ⊆⍨ 0 = {⊃,/ (Leap Pair tokens ⍷⍙ ⍵) ∧ '`'=⍵} Part ⍵
}

Mrk ← { msk ← 1↑⍨(≢⍺)-1 ⋄ (⊃ ∧∘Ⓣ 0=msk∘Ⓡ)<\⍺⍷⍵ } ⍝ Reflect characters after prefix
Rmv ← { msk ← 1↑⍨1-(≢⍺) ⋄ (⍵/⍨∘Ⓟ 0=msk∘Ⓡ)<\⍺⍷⍵ } ⍝ Remove first occurence of sub-string

UCMD ← {(1↓⍺),⍵}{ u ← ⍺(⊢ ⊂⍨∘≠ Mrk)⍵,' ' ⋄ 1 0≡(⊂⍺)⍷u: ⊃⍺⍺/u ⋄ ⍵ }∘Trim

Parse ← { ~∘(⊂'') ((⍸⍺∘Mrk)⌷⍙⊢)¨⍵ }

Shrink ← { w ← ⊃,/⍵ ⋄ w ⊆⍨ (≢w) ↑ (⍸ ↑⍨ ⍺ (⊣-+.>) +\) ≢¨⍵ }

Lines  ← {⊃,⍥⊆/'```'(⊂⍤¯1 ⎕FMT⍵)'```'}

⍝ Recieves a possibly formatted command, returns APL-strings (to be executed).

Handle ← {1 ⎕JSON 2000 Shrink ⊃,/(Lines∘display∘{0::⎕DMX.Message ⋄ ⍎⍵})¨ 'dyalog)' Parse Format⍵}

:EndNameSpace