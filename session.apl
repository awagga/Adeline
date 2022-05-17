#!/usr/local/bin/dyalogscript
Ï ← ⎕FIX'file://',⊢

⎕IO ← 1

'display'⎕CY'dfns'

⎕SE⎕WS'File' '/opt/mdyalog/18.2/64/unicode/default.dse' ⋄ 2⎕NQ⎕SE'FileRead'

⎕SE.UCMD'box on -style=max -trains=tree'

Ï 'dice.apl'
Ï 'Safe.dyalog'

⎕ ← ⍎ ⊃0 1/ (2 ⎕NQ # 'GetCommandLineArgs')
