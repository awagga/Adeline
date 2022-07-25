import Eris from "eris";import WebSocket from "ws";import { readFile } from "fs";import MessagePack from "@msgpack/msgpack";import { Readable } from "stream";

readFile("message.dyalog", "utf8", (_err, messageNameSpace) => {
  
const Handle = async (msg) => { if (msg.author.id == client.user.id || !msg.content.includes("dyalog)")) return;
  let socket = new WebSocket("wss://dyalog.run/api/v0/ws/execute");
  let expr = "⎕ ← Message.Handle" + "'" + msg.content.replace(/'/g, "''") + "'";

    socket.onopen = () => { socket.send(MessagePack.encode({language: "dyalog_apl", code: messageNameSpace + "\n" + expr, timeout: 5})) };
    socket.onmessage = async (event) => {
      const r = await MessagePack.decodeAsync(Readable.from(event.data));
      if (r.timed_out) {
        client.createMessage(
          msg.channel.id,
          "```LIMIT ERROR: Expressions must finish within 5 seconds.```"
        );
      } else {
        client.createMessage(
          msg.channel.id,
          JSON.parse(
            new TextDecoder().decode(
              [r.stdout, r.stderr].filter((x) => x.length != 0)[0]
            )
          ).join("\n")
        );
      }
    };
  };

  const client = new Eris(process.env.adeline);
  client.on("messageCreate", Handle);client.on("messageUpdate", Handle);client.connect();
})

process.on("uncaughtException", (err) => console.error(err));
