// messages_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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
  String myUserId = "";

  @override
  void initState() {
    super.initState();
    _fetchChats();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    final id = await storage.read(key: "userId");
    if (id != null) {
      setState(() {
        myUserId = id;
      });
    }
  }

  Future<void> _fetchChats() async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) return;

      final url = "${dotenv.env['BACKEND_URL']}/app/chats";
      final res = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        setState(() {
          messages = data.map<Map<String, dynamic>>((chat) {
            final lastMessage = chat['lastMessage'] ?? {};
            final participant = chat['participants'].firstWhere(
              (p) => p['_id'] != myUserId,
              orElse: () => {},
            );

            return {
              "chatId": chat["_id"],
              "userId": participant['_id'], // ✅ store other participant ID
              "name": participant['name'] ??
                  "${participant['firstName'] ?? ''} ${participant['lastName'] ?? ''}".trim(),
              "msg": lastMessage['content'] ?? "",
              "time": lastMessage['createdAt'] ?? "",
              "avatar": (participant['avatarUrl'] as String?)?.trim().isNotEmpty == true
                  ? participant['avatarUrl']
                  : "${dotenv.env['BACKEND_URL']}/BeFab.png",
            };
          }).toList();
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      print("Error fetching chats: $e");
      setState(() => loading = false);
    }
  }

  void _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() => searchResults = []);
      return;
    }

    final token = await storage.read(key: "token");
    if (token == null) return;

    final url = "${dotenv.env['BACKEND_URL']}/app/users/search?q=$query";
    final res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      setState(() {
        searchResults = data.map<Map<String, dynamic>>((user) {
          return {
            "userId": user['_id'],
            "name": user['name'] ??
                "${user['firstName'] ?? ''} ${user['lastName'] ?? ''}".trim(),
            "avatar": (user['avatarUrl'] as String?)?.trim().isNotEmpty == true
                ? user['avatarUrl']
                : "${dotenv.env['BACKEND_URL']}/BeFab.png",
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: Column(
        children: [
          // 🔎 search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchUsers,
              decoration: const InputDecoration(
                hintText: "Search users...",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // 🔎 search results
          if (searchResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final user = searchResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['avatar']),
                    ),
                    title: Text(user['name']),
                    onTap: () async {
                      // Call backend to create or get existing chat
                      final token = await storage.read(key: "token");
                      final url =
                          "${dotenv.env['BACKEND_URL']}/app/chats/with/${user['userId']}";

                      final res = await http.post(
                        Uri.parse(url),
                        headers: {"Authorization": "Bearer $token"},
                      );

                      if (res.statusCode == 200) {
                        final data = json.decode(res.body);
                        final chatId = data['chatId'];

                        if (mounted) {
                          Navigator.pushNamed(
                            context,
                            '/chat-screen',
                            arguments: {
                              "chatId": chatId,
                              "userId": user['userId'],
                              "name": user['name'],
                            },
                          );
                        }
                      }
                    },
                  );
                },
              ),
            )
          else if (loading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final chat = messages[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(chat['avatar']),
                    ),
                    title: Text(chat['name']),
                    subtitle: Text(chat['msg']),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat-screen',
                        arguments: {
                          "chatId": chat['chatId'],
                          "userId": chat['userId'], // ✅ fixed
                          "name": chat['name'],
                        },
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
