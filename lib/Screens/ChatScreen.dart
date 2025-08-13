import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [
    ChatMessage(
      text:
          "Saw young fathers with Massive Attack in Berlin, amazing band, especially live 🔥",
      isMe: true,
      timestamp: "2 mins ago",
    ),
    ChatMessage(
      text: "Thats all from Pitchfork?",
      isMe: true,
      timestamp: "Read 10:43",
    ),
    ChatMessage(text: "no, from here", isMe: false, timestamp: "1 min ago"),
    ChatMessage(
      text: "Long Headline Tw...",
      isMe: false,
      hasMedia: true,
      subtitle: "Subtitle",
    ),
    ChatMessage(text: "I'm ill check", isMe: true, timestamp: "Read 10:43"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
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
          // 🧑 Profile avatar with green dot using Stack + Positioned
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

      ),
      // appBar: CustomAppBar(
      //   leftWidget: Row(
      //     children: [
      //       SvgPicture.asset('assets/images/Arrow.svg', width: 14, height: 14),
      //       SizedBox(width: 4),
      //       Text(
      //         "Back",
      //         style: TextStyle(
      //           color: Color(0xFF862633),
      //           fontSize: 17,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
      //     ],
      //   ),
      //   onLeftTap: () => Navigator.pop(context),
      //   title: "Surname",
      //   rightWidget: Row(
      //     children: [
      //       Stack(
      //         children: [
      //           const CircleAvatar(
      //             radius: 18,
      //             backgroundImage: AssetImage('assets/images/pic8.jpg'),
      //           ),
      //           Positioned(
      //             bottom: 2,
      //             right: 2,
      //             child: Container(
      //               width: 10,
      //               height: 10,
      //               decoration: const BoxDecoration(
      //                 color: Colors.green,
      //                 shape: BoxShape.circle,
      //                 border: Border.fromBorderSide(
      //                   BorderSide(color: Colors.white, width: 1.5),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final messageIndex = messages.length - 1 - index;
                final message = messages[messageIndex];
                final nextMessage =
                    messageIndex < messages.length - 1
                        ? messages[messageIndex + 1]
                        : null;
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

        // Message input field
        Expanded(
          child: Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Color(0xFFCCCCCC), // Light grey border
      width: 1.5,
    ),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Placeholder",
            style: TextStyle(color: Color(0xFF999999), fontSize: 16),
          ),
        ),
      ),

      // ⬆️ Send Arrow Button
      Align(
        alignment: Alignment.center,
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
)
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
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
  child: ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * 0.6, // Max width
    ),
    child: IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: message.isMe ? Color(0xFF862633) : Color(0xFFF3F3F3),
          borderRadius: BorderRadius.all(
            Radius.circular(16)
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
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
                  if (message.subtitle != null) ...[
                    Text(
                      message.subtitle!,
                      style: TextStyle(
                        color: message.isMe ? Colors.white70 : Color(0xFF999999),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (message.hasMedia) ...[
              SizedBox(width: 8),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  ),
)

            ],
          ),
          if (showTimestamp)
            Padding(
              padding: EdgeInsets.only(
                top: 4,
                left: message.isMe ? 0 : 0,
                right: message.isMe ? 0 : 0,
              ),
              child: Text(
                message.timestamp,
                style: TextStyle(color: Color(0xFF999999), fontSize: 12),
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
     this.text="",
    required this.isMe,
     this.timestamp="",
    this.hasMedia = false,
    this.subtitle,
  });
}
