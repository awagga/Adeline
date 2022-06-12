import Eris from "eris"; import execFileSync from "child_process"

const c = new Eris(process.env.adeline);c.on("messageCreate",
(m)=>{if(m.author.id==c.user.id||!m.content.includes('dyalog)'))return
 process.env.expr = "Command.Handle" + "'" + m.content.replace(/'/g, "''") + "'"
 c.createMessage(m.channel.id, JSON.parse(execFileSync("./dyalog")).join("\n"))
});c.connect();process.on("uncaughtException",(e)=>console.error(e))
