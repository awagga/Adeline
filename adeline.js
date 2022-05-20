import    Eris   from "eris"         ;
import { spawn } from "child_process";
import {  once } from "events"       ;

const Print  = console.log;
const Format = (string) => { return "```" + `${string}`.substring(0, 1990) + "```" };

const client = new Eris(process.env.adeline);

async function APL(msg, input) {
  let process = spawn("./session.apl", [input]);
  
  let output = ""; 
  
  process.stdout.on("data", (data) => { output += data.toString() });

  var timeout = setTimeout(() => { process.kill("SIGINT");
    client.createMessage(msg.channel.id, Format("EXPRESSION TIME LIMIT EXCEEDED: Must complete within 10 seconds"))
  }, 10000);

  process.on("exit", () => { clearTimeout(timeout) });await once(process, "exit");return output;
}

async function handle(msg) {
  if (!msg.content.includes("dyalog)")) return;

  for (const c of JSON.parse(
    await APL(msg,
       "(Msg.Handle)'" + msg.content.replace(/'/g, "''") + "'")
  )) 
    client.createMessage(msg.channel.id,
      Format(await APL(msg, "(display)" + c))); 
}

client.on("messageCreate", async (msg) => { if (msg.author.id != client.user.id) handle(msg) });
client.on("ready"        , async (_)   => Print("connected!"));

client.connect();
