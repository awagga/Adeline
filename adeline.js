import Eris from "eris";import { spawn, exec } from "child_process";

const P = console.log;
const c = new Eris(process.env.adeline);
const F = (o) => {
  return "```haskell\n" + `${o}`.substring(0, 1500) + "```";
};

async function dyalog(m, code) {
    exec(`./session.apl "${code}"`, (stdout, stderr) => {
      c.createMessage(m.channel.id, F([stdout, stderr].filter(Boolean)));
    });
}

async function handle(m) { 
  let proc = spawn("./exec.apl", [`Utils.Format '${m.content.replace(/'/g,"''")}'`]);
  proc.stderr.on("data", (r) => { return P(r.toString()) });
  proc.stdout.on("data", (r) => {
    let code = r.toString().split(" ");if (code[0] == "dyalog)") dyalog(m, code.slice(1).join(" ").trim());
  });
}

c.on("messageCreate", async (m) => { if (!m.author.bot) handle(m);});
c.on("ready"        , async (_) => P("connected!"));
c.connect();
