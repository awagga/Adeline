import Eris from "eris"; import WebSocket from 'ws'; import 'fs'; import 'msgpack';

const Handle = async (msg) => { if (msg.author.id == client.user.id || !msg.content.includes('dyalog)')) return
 let socket = new WebSocket("wss://dyalog.run/api/v0/ws/execute");
 let expr = "⎕ ← Message.Handle" + "'" + msg.content.replace(/'/g, "''") + "'"

 fs.readFile('message.dyalog', 'utf8', (_err, data) => {
    socket.onopen = () => { socket.send(MessagePack.encode({language: "dyalog_apl", code: data + '\n' + expr, timeout: 5, }) ); } 
    socket.onmessage = async (event) => { 
        client.createMessage(msg.channel.id, JSON.parse(new TextDecoder().decode((await MessagePack.decodeAsync(event.data.stream())).stdout)).join('\n'))
    };
 })
}
const client = new Eris(process.env.adeline);client.on("messageCreate",Handle);client.on("messageUpdate",Handle);client.connect()

process.on("uncaughtException",(err)=>console.error(err))
