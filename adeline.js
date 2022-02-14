const Eris = require("eris");
const exec = require("child_process").exec;
global.P = console.log;

const c = new Eris.CommandClient(process.env.adeline, {}, { prefix: "?" });

async function shell(cmd) {
  return new Promise((resolve, reject) =>
    exec(cmd, (err, stdout, stderr) =>
      err ? reject(err) : resolve({ stdout, stderr })
    )
  );
}

c.registerCommand("apl", async (msg, args) => {
  let { stdout, stderr } = await shell(
    `mapl -script R.apl "${args.join(" ")}"`
  );
  c.createMessage(
    msg.channel.id,
    "```" + `haskell\n${stdout ? stdout : stderr}` + "```"
  );
});

c.on("ready", async (_) => P("connected!"));

c.connect();
