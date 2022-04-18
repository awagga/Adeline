const Eris = require("eris");
const exec = require("child_process").exec;
global.P   = console.log;

const c    = new Eris.CommandClient(process.env.adeline, {}, { prefix: "?" });

const I    = (s) => { P(s); return s; }
const Fmt  = (s) => {       return "```haskell\n" + s + "```"; }

async function _cApl(msg, args) {
  exec(I(`./R.apls "${args.join(" ")}"`),
 (error, stdout, stderr) => { c.createMessage(msg.channel.id, Fmt([stdout, stderr].filter(Boolean))); } 
);}

c.registerCommand("apl", _cApl);

c.on("ready", async (_) => P("connected!"));

c.connect();
