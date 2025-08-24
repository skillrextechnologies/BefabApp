import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Map<String, dynamic>> messages = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchChats();
  }

  Future<void> _fetchChats() async {
    try {
      final url = "${dotenv.env['BACKEND_URL']}/app/chats";
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        setState(() {
          // Map backend data to your UI structure
          messages = data.map((chat) {
            final lastMessage = chat['lastMessage'] ?? {};
            final participant = chat['participants']
                .firstWhere((p) => p['_id'] != 'YOUR_USER_ID'); // replace with logged-in ID
            return {
              "chatId": chat["_id"],
              "name": participant['name'] ?? "User",
              "msg": lastMessage['content'] ?? "",
              "time": lastMessage['createdAt'] ?? "",
              "avatar": "assets/images/pic1.jpg", // optional, or load from backend
            };
          }).toList();
          loading = false;
        });
      } else {
        print("Failed to load chats: ${res.statusCode}");
        setState(() => loading = false);
      }
    } catch (e) {
      print("Error fetching chats: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search messages",
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF637587),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      final chat = messages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/chat-screen',
                            arguments: {
                              "chatId": chat['chatId'],
                              "name": chat['name'],
                            },
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                chat['avatar'],
                                fit: BoxFit.cover,
                                width: 45,
                                height: 45,
                              ),
                            ),
                          ),
                          title: Text(
                            chat['name'] ?? "User",
                            style: TextStyle(
                              color: Color(0xFF121417),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            chat['msg'] ?? "",
                            style: TextStyle(
                              color: Color(0xFF637587),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Text(
                            _formatTime(chat['time']),
                            style: TextStyle(
                              color: Color(0xFF637587),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: IconButton(
          icon: const Icon(
            Icons.add_circle,
            size: 70,
            color: Color(0xFF862633),
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 4),
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
        'Inbox',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/settings2.svg',
            width: 24,
            height: 24,
            color: Color(0xFF862633),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  String _formatTime(String isoTime) {
    try {
      final dt = DateTime.parse(isoTime);
      return "${dt.day}/${dt.month}";
    } catch (_) {
      return isoTime; // fallback if parsing fails
    }
  }
}
