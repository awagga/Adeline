const Eris = require("eris");
const { exec, spawn } = require("child_process");
global.P = console.log;

const c = new Eris.CommandClient(process.env.adeline, {}, { prefix: "?" });

const Fmt = (o) => {
  return "```haskell\n" + `${o}`.substr(0,1500) + "```"
};

async function _cApl(msg, args) {
  exec(`./R.apls "${args.join(" ")}"`, (_error, stdout, stderr) => {
    c.createMessage(msg.channel.id, Fmt([stdout, stderr].filter(Boolean)));
  });
}

async function _cIjc(msg, args) {
  I = spawn("I");

  I.stdin.write(`${args.join(" ")}\n`);
  I.stdout.on("data", (data) => {
    c.createMessage(msg.channel.id, Fmt(data));
    I.kill();
  });
}

c.registerCommand("apl", _cApl);
c.registerCommand("ijc", _cIjc);

c.on("ready", async (_) => P("connected!"));

c.connect();
