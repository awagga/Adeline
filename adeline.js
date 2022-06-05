import   Eris       from "eris"
import { execFile } from "child_process"
import { once }     from "events"
import   kill       from "tree-kill"

let languages = { "i)": "echo", "dyalog)": "./dyalog" }

async function execute(lang, source) { const child = execFile(lang, [source]); let o = ""
  const tid = setTimeout(() => {
    o += "EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds";
    kill(child.pid, "SIGKILL");
  }, 10000);

  child.stdout.on("data", (data) => {
    o += data.toString();
  });
  
  child.on("exit", () => {
    clearTimeout(tid);
  });

  await once(child, "exit") // Wait.
  return o
}

const c = new Eris(process.env.adeline);
      c.on("messageCreate", async (msg) => {
  if (!Object.keys(languages).some((k)  => msg.content.includes(k))) return; // Shortcut

  if (msg.author.id == c.user.id) return;

  JSON.parse( // Vector of code-blocks
    await execute(languages["dyalog)"],
      "Command.Handle" + "'" + msg.content.replace(/'/g, "''") + " '" // Prepend space; scalar -> vector
    )
  ).reduce(async (promise, arr) => { await promise; let [lang, source] = arr;
    if (source) // Is empty? I.e - was prefix present?
      c.createMessage(msg.channel.id,
        "```" + (await execute(languages[lang], source)) + "```"
      );
  }, Promise.resolve());
});
c.connect()
