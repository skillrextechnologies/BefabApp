import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final storage = const FlutterSecureStorage();

  List<Map<String, dynamic>> messages = [];
  List<Map<String, dynamic>> searchResults = [];
  bool loading = true;
  bool searching = false;
  final TextEditingController _searchCtrl = TextEditingController();

  String? myUserId; // logged-in userId

  @override
  void initState() {
    super.initState();
    _initUserAndChats();
  }

  Future<void> _initUserAndChats() async {
    await _fetchUserId();
    await _fetchChats();
  }

  Future<void> _fetchUserId() async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        print("No token found");
        return;
      }

      final url = "${dotenv.env['BACKEND_URL']}/app/get";
      final res = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          myUserId = data["_id"];
        });
      } else {
        print("Failed to fetch user: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  Future<void> _fetchChats() async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        print("No token found");
        return;
      }

      final url = "${dotenv.env['BACKEND_URL']}/app/chats";
      final res = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        setState(() {
          messages = data.map((chat) {
            final lastMessage = chat['lastMessage'] ?? {};
            // exclude current user from participants
            final participant = chat['participants'].firstWhere(
              (p) => p['_id'] != myUserId,
              orElse: () => {},
            );
            return {
              "chatId": chat["_id"],
              "name": participant['name'] ??
                  "${participant['firstName'] ?? ''} ${participant['lastName'] ?? ''}".trim(),
              "msg": lastMessage['content'] ?? "",
              "time": lastMessage['createdAt'] ?? "",
              // CHANGED: use backend avatarUrl, else fallback to BACKEND_URL/BeFab.png
              "avatar": (participant['avatarUrl'] as String?)?.trim()?.isNotEmpty == true
                  ? participant['avatarUrl']
                  : "${dotenv.env['BACKEND_URL']}/BeFab.png",
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

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        searching = false;
        searchResults = [];
      });
      return;
    }
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        print("No token found");
        return;
      }

      final url = "${dotenv.env['BACKEND_URL']}/app/users?query=$query";
      final res = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        setState(() {
          searching = true;
          searchResults = data.map<Map<String, dynamic>>((u) {
            final String? av = (u["avatarUrl"] as String?);
            return {
              "userId": u["_id"],
              "name": "${u["firstName"] ?? ''} ${u["lastName"] ?? ''}".trim(),
              "username": u["username"],
              // CHANGED: prefer avatarUrl else BACKEND_URL/BeFab.png
              "avatar": (av?.trim().isNotEmpty ?? false)
                  ? av
                  : "${dotenv.env['BACKEND_URL']}/BeFab.png",
            };
          }).toList();
        });
      } else {
        print("Failed to search users: ${res.statusCode}");
      }
    } catch (e) {
      print("Error searching users: $e");
    }
  }

  // helper to render either network or asset without changing your layout
  Widget _avatarWidget(String? src, {double w = 45, double h = 45}) {
    final s = src ?? "";
    final isNet = s.startsWith("http://") || s.startsWith("https://");
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: isNet
          ? Image.network(s, fit: BoxFit.cover, width: w, height: h)
          : Image.asset(s, fit: BoxFit.cover, width: w, height: h),
    );
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
                      controller: _searchCtrl,
                      onChanged: _searchUsers,
                      decoration: InputDecoration(
                        hintText: "Search messages or people",
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

                // Show search results if searching
                if (searching)
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (_, index) {
                        final user = searchResults[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: _avatarWidget(user['avatar'], w: 40, h: 40), // CHANGED
                          ),
                          title: Text(user['name']),
                          subtitle: Text(user['username']),
                          onTap: () async {
                            final res = await http.post(
                              Uri.parse("${dotenv.env['BACKEND_URL']}/app/chats"),
                              headers: {
                                "Authorization":
                                    "Bearer ${await storage.read(key: "token")}",
                                "Content-Type": "application/json",
                              },
                              body: jsonEncode({
                                "participantIds": [user['userId']],
                              }),
                            );

                            if (res.statusCode == 201 || res.statusCode == 200) {
                              final data = jsonDecode(res.body);
                              final chatId = data["_id"]; // conversation id

                              Navigator.pushNamed(
                                context,
                                '/chat-screen',
                                arguments: {
                                  "userId": user['userId'], // the other user
                                  "chatId": chatId, // conversation id
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failed to start chat")),
                              );
                            }
                          },
                        );
                      },
                    ),
                  )
                else
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
                              child: _avatarWidget(chat['avatar'], w: 45, h: 45), // CHANGED
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
