import    Eris   from "eris"         ;
import { spawn } from "child_process";
import {  once } from "events"       ;

const P = console.log;
const F = (o) => { return "```" + o.slice(0, 1993) + "```" };
const c = new Eris(process.env.adeline);

const e = "EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds";

async function A(i) {
  let p = spawn("./apl", [i]);
  let o = "";
  
  p.stdout.on("data",(d)=>{ o+=d.toString()});
         p.on("exit",( )=>{ clearTimeout(t)});
  var t = setTimeout(( )=>{ o+=e
    p.kill()}, 10000);
  
  await once(p, "exit");return o;
}

async function H(m) {
  let s = "(Command.Handle)" + "'" + m.content.replace(/'/g, "''") + "'";
  let v = JSON.parse(await A(s));
  for (let u of v) c.createMessage(m.channel.id, F(await A("(display)" + u))); 
}

c.on("messageCreate",async(m) => H(m));
c.on("ready"        ,async(_) => P(1));
c.connect();