import   Eris       from "eris"
import { execFile } from "child_process"
import { once }     from "events"

const c = new Eris(process.env.adeline); 

c.on("messageCreate", async (msg) => {
  
  if (!msg.content.includes('dyalog)') || msg.author.id == c.user.id) return;

  const child = execFile('./dyalog', ["Command.Handle" + "'" + msg.content.replace(/'/g, "''") + " '"])
  
  let output = ""; child.stdout.on("data", (data) => { output += data.toString() }); await once(child, "exit");

  JSON.parse(output).map(o => c.createMessage(msg.channel.id, "```" + o.join("\n").slice(0,1993) + "```" ));
});
c.connect()
