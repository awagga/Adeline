#!/usr/local/bin/dyalogscript
Ï ← ⎕FIX'file://',⊢

⎕IO ← 1

'display'⎕CY'dfns'

⎕SE⎕WS'File' '/opt/mdyalog/18.2/64/unicode/default.dse' ⋄ 2⎕NQ⎕SE'FileRead'

Ï 'dice.apl'

display {
    ⍳11::⎕DMX.EM,': ',⎕DMX.Message
    ⍎ ⊃0 1/ (2 ⎕NQ # 'GetCommandLineArgs')
}⍬
