import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io("http://10.0.2.2:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();

    socket.onConnect((_) {
      print("✅ Connected to socket server");
    });

    socket.onDisconnect((_) {
      print("❌ Disconnected from socket server");
    });

    socket.onConnectError((err) => print("⚠️ Connect Error: $err"));
    socket.onError((err) => print("⚠️ Socket Error: $err"));
  }

  void joinChat(String chatId) {
    socket.emit("joinChat", chatId);
    print("📌 Joined chat $chatId");
  }

  void sendMessage({
    required String chatId,
    required String senderId,
    required String content,
    String? mediaUrl,
    String mediaType = "none",
  }) {
    socket.emit("sendMessage", {
      "chatId": chatId,
      "senderId": senderId,
      "content": content,
      "mediaUrl": mediaUrl,
      "mediaType": mediaType,
    });
  }

  void onNewMessage(Function(dynamic) callback) {
    socket.on("newMessage", callback);
  }
}
