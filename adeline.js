import    Eris   from "eris"         ;
import { spawn } from "child_process";
import {  once } from "events"       ;

const P = console.log;
const F = (o) => { return "```" + o.slice(0, 1993) + "```" };
const c = new Eris(process.env.adeline);
const S = c.createMessage;

async function A(m,i) {
  let p = spawn("./apl", [i]);

  let o = "";p.stdout.on("data", (d) => { o += d.toString() });

  var timeout = setTimeout(() => { p.kill();S(m.channel.id,
    F("EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds")) }, 10000);
  
  p.on("exit", () => { clearTimeout(timeout) });await once(p, "exit");return o;
}

async function H(m) {
  let s = "(Command.Handle)" + "'" + m.content.replace(/'/g, "''") + "'";
  let v = JSON.parse(await A(m,s));
  for (let u of v) S(m.channel.id, F(await A(m, "(display)" + u))); 
}

c.on("messageCreate", async (m) => H(m));
c.on("ready"        , async (_) => P(1));
c.connect();
