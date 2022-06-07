import Eris from "eris"; import { execFile } from "child_process";

const c = new Eris(process.env.adeline);
c.on("messageCreate", (m) => { if (!/(?<=[` ])dyalog\)/g.test(" " + m.content) || m.author.id == c.user.id) return
  execFile("./dyalog", ['Command.Handle' + "'" + m.content.replace(/'/g, "''") + "'"]).stdout.on("data", (o) => c.createMessage(m.channel.id, JSON.parse(o).join("\n").slice(0, 1990)))
});c.connect()

process.on("uncaughtException", (e) => console.error(e)); // Paranoia