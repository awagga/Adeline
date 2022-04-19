import { CommandClient } from "eris"
import  { exec, spawn }  from "child_process"

const P = console.log

const c = new CommandClient(process.env.adeline, {}, { prefix: "?" })

const F = (o) => { return "```haskell\n" + `${o}`.substring(0,1500) + "```" }

async function APL(m, a) { const x = a.join(" ")
 exec(`./exec.apl "${x}"`, (stdout, stderr) => { c.createMessage(m.channel.id, F([stdout, stderr].filter(Boolean))) })
}
async function   I(m, a) { const x = a.join(" ")
 let proc = spawn("I"); proc.stdout.on("data", (data) => { c.createMessage(m.channel.id, F(data)); proc.kill() })
 
 proc.stdin.write(`${x}\n`)
}

c.registerCommand("apl", APL)
c.registerCommand("i", I)


c.on("ready", async (_) => P("connected!"));c.connect()