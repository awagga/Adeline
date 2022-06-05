import   Eris       from "eris"
import { execFile } from "child_process"
import { once }     from "events"
import   kill       from "tree-kill"

let languages = { "i)": "echo", "dyalog)": "./dyalog" }

async function execute(lang, source) { const child = execFile(lang, [source]); let output = ""
  const tid = setTimeout(() => {
    output += "EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds"
    kill(child.pid, "SIGKILL")
  }, 10000)

  child.stdout.on("data", (data) => { output += data.toString() })
  
  child.on("exit", () => { clearTimeout(tid) })

  await once(child, "exit")

  return output
}

const client = new Eris(process.env.adeline)
client.on("messageCreate", async (msg) => {
  if (!Object.keys(languages).some(k => msg.content.includes(k))) return;

  if (msg.author.id == client.user.id) return;

  const v = JSON.parse( // Vector of code-blocks
    await execute(
      "./dyalog",
      "Command.Handle" + "'" + msg.content.replace(/'/g, "''") + " '" // Prepend space; scalar -> vector
    ))

  await v.reduce(async (promise, block) => { await promise
    if (block[1]) // Was language prefix present?
      client.createMessage(
        msg.channel.id,
        "```" + (await execute(languages[block[0]], block[1])) + "```" )
  }, Promise.resolve())})
client.connect()
