import Eris from "eris"; import { execFileSync } from "child_process"
const pfx = 'dyalog)'
const H = async(m)=>{ if (m.author.id == c.user.id || !m.content.includes(pfx)) return
 process.env.expr = "Command.Handle" + "'" + m.content.replace(/'/g, "''") + "'"
 c.createMessage(m.channel.id, JSON.parse(execFileSync("./" + pfx)).join("\n"))}
const c = new Eris(process.env.adeline);c.on("messageCreate",H);c.on("messageUpdate",H);c.connect()
process.on("uncaughtException",(e)=>console.error(e))
