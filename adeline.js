const Eris = require("eris");
const exec = require("child_process").exec;
global.P = console.log;

const c = new Eris.CommandClient(process.env.adeline, {}, { prefix: "?" });

const any = (v) => v.reduce((x, y) => (x ? x : y), undefined);

c.registerCommand("apl", async (msg, args) => {
  exec(`export EX="${args.join(" ")}" && ./R.apls`, (error, stdout, stderr) => {
    c.createMessage(msg.channel.id, "```" + any([stdout, stderr]) + "```");
  });
});

c.on("ready", async (_) => P("connected!"));

c.connect();
