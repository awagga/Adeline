import Eris from "eris";import { spawn } from "child_process";

const P = console.log;
const c = new Eris(process.env.adeline);
const F = (o) => { return "```" + `${o}`.substring(0, 1500) + "```"; };

async function dyalog(m, code) {
  let p = spawn("./session.apl", [code]);
  
  p.stdout.on("data", (r) => { c.createMessage(m.channel.id, F(r)) });

  var timeout = setTimeout(() => {
    p.kill("SIGINT");
    c.createMessage(m.channel.id,
       F("EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds"));
  }, 10000);

  p.on("exit", () => { clearTimeout(timeout); });
}

async function handle(m) {
  let p = spawn("./exec.apl", [`Utils.Format '${m.content.replace(/'/g, "''")}'`]);

  p.stderr.on("data", (r) => { throw r.toString() });
  p.stdout.on("data", (r) => {
    let code = r.toString().split(" "); if (code[0] == "dyalog)") dyalog(m, code.slice(1).join(" ").trim());
  });
}

c.on("messageCreate", async (m) => { if(!m.author.bot) handle(m) });
c.on("ready"        , async (_) => P("connected!"))
c.connect();
