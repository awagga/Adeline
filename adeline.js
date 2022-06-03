import    Eris   from "eris"         ;
import { spawn } from "child_process";
import {  once } from "events"       ;

const P = console.log;
const F = (s) => { return "```" + s.slice(0, 1993) + "```" };
const c = new Eris(process.env.adeline);

async function A(i) {
  let p = spawn("./apl", [i]);

  var t = setTimeout(( ) => { o += "EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds"; p.kill()}, 10000);
  p.stdout.on("data",(d) => { o += d.toString()});
         p.on("exit",( ) => {  clearTimeout(t) });
  
  let o = "";await once(p, "exit");return o;
}

async function H(m) {
  let s = "(Command.Handle)" + "'" + m.content.replace(/'/g, "''") + "'";
  let v = JSON.parse(await A(s));
  
  await v.reduce(async (promise, u) => {
    await promise;c.createMessage(m.channel.id, F(await A("(display)" + u)));}, Promise.resolve());
}

c.on("messageCreate",async(m) => H(m));
c.on("ready"        ,async(_) => P(1));
c.connect();