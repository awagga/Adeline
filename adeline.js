import Eris from "eris";
import { execFile } from "child_process";
import { once } from "events";

const c = new Eris(process.env.adeline);
c.on("messageCreate", async (m) => { if (m.author.id == c.user.id || !m.content.includes('dyalog)')) return;
  process.env.expr = "Command.Handle" + "'" + m.content.replace(/'/g, "''") + "'";
  let o = "";
  let child = execFile("./dyalog");
  child.stdout.on("data", (d) => {
    o += d.toString();
  });
  await once(child, "exit");
  c.createMessage(m.channel.id, JSON.parse(o).join("\n"));
});c.connect();

process.on("uncaughtException", (e) => console.error(e)); // Paranoia
