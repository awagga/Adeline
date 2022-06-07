import Eris from "eris"; import { execFile } from "child_process"

const c = new Eris(process.env.adeline)
c.on("messageCreate", (m) => { if (m.author.id == c.user.id) return;
  process.env.expr = "Command.Handle" + "'" + m.content.replace(/'/g, "''") + "'"
  execFile("./dyalog").stdout.on("data", (o) =>
    c.createMessage(m.channel.id, JSON.parse(o).join("\n"))
  )
});c.connect();

process.on("uncaughtException", (e) => console.error(e)); // Paranoia