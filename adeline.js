import Eris from "eris"; import { execFile } from "child_process";

const c = new Eris(process.env.adeline);
c.on("messageCreate", (m) => { if (!m.content.includes('dyalog)') || m.author.id == c.user.id) return;
  process.env.expr = 'Command.Handle' + "'" + m.content.replace(/'/g, "''") + "'";
  execFile(`./dyalog`).stdout.on("data", (o) => { console.log(o);c.createMessage(m.channel.id, JSON.parse(o).join("\n").slice(0, 1990)) });
});
c.connect();

process.on("uncaughtException", (e) => console.error(e)); // Paranoia
