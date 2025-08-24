import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/chat_service.dart'; // socket service
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userId;

  const ChatScreen({required this.chatId, required this.userId, super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchPreviousMessages();
    _setupSocket();
  }

  // 1️⃣ Fetch old messages from backend
  Future<void> _fetchPreviousMessages() async {
    try {
      final url = "${dotenv.env['BACKEND_URL']}/app/chats/${widget.chatId}/messages";
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        setState(() {
          messages = data
              .map((msg) => ChatMessage(
                    text: msg['content'] ?? '',
                    isMe: msg['sender']['_id'] == widget.userId,
                    timestamp: _formatTimestamp(msg['createdAt']),
                  ))
              .toList();
        });
        // scroll to bottom after loading
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      } else {
        print("Failed to load messages: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  // 2️⃣ Setup Socket.IO for real-time messages
  void _setupSocket() {
    _chatService.connect(widget.userId);
    _chatService.joinChat(widget.chatId);

    _chatService.onNewMessage((data) {
      final newMsg = ChatMessage(
        text: data['content'] ?? '',
        isMe: data['sender'] == widget.userId,
        timestamp: _formatTimestamp(data['createdAt']),
      );
      setState(() {
        messages.add(newMsg);
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String _formatTimestamp(String iso) {
    final dt = DateTime.parse(iso);
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} mins ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    return "${dt.day}/${dt.month}/${dt.year}";
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    _chatService.sendMessage(
      chatId: widget.chatId,
      senderId: widget.userId,
      content: _controller.text.trim(),
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final nextMessage =
                    index < messages.length - 1 ? messages[index + 1] : null;
                final showTimestamp =
                    nextMessage == null || nextMessage.isMe != message.isMe;

                return ChatBubble(
                  message: message,
                  showTimestamp: showTimestamp,
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 100,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'assets/images/Arrow.svg',
                width: 14,
                height: 14,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Back',
              style: TextStyle(
                color: Color(0xFF862633),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Surname',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/pic8.jpg'),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Color(0xFFCCCCCC), width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF862633),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showTimestamp;

  const ChatBubble({Key? key, required this.message, this.showTimestamp = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: message.isMe ? Color(0xFF862633) : Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: message.isMe ? Colors.white : Color(0xFF333333),
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (message.subtitle != null)
                  Text(
                    message.subtitle!,
                    style: TextStyle(
                      color: message.isMe ? Colors.white70 : Color(0xFF999999),
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ),
          if (showTimestamp)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                message.timestamp,
                style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String timestamp;
  final bool hasMedia;
  final String? subtitle;

  ChatMessage({
    this.text = "",
    required this.isMe,
    this.timestamp = "",
    this.hasMedia = false,
    this.subtitle,
  });
}
