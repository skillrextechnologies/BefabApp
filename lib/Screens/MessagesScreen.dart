import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class MessagesPage extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      "name": "Olivia Smith",
      "msg": "I’m actually switching this Car!",
      "time": "9/7",
    },
    {
      "name": "Ethan Johnson",
      "msg": "Can you confirm that my Car is ready?",
      "time": "6/17",
    },
    {"name": "Ava Martinez", "msg": "Just want to say hi!", "time": "7:05"},
    {
      "name": "Emily Garcia",
      "msg": "do you know where i can find good designer?",
      "time": "7/30",
    },
    {
      "name": "Liam Davis",
      "msg": "they ran out of sashimis 🥲",
      "time": "2/22",
    },
    {
      "name": "Mia Rodriguez",
      "msg":
          "You’re so inspiring! Your fitness journey has motivated me to start!",
      "time": "11/23",
    },
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
              const SizedBox(width: 6), // Minor gap between icon and text
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

        /// 👉 Add Settings Icon to the trailing side
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/settings2.svg', // Update path based on your asset structure
              width: 24,
              height: 24,
              color: Color(0xFF862633), // Optional: tint the image
            ),
            onPressed: () {
              // TODO: Handle settings tap
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
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
                      isCollapsed: true, // removes extra vertical space
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ), // better vertical alignment
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
                  itemBuilder:
                      (_, index) => GestureDetector(
                        onTap: () {
        Navigator.pushNamed(context, '/chat-screen');
      },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30, // ↑ increase from default (~20) to 30
                            backgroundColor:
                                Colors.grey[200], // optional background
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/images/pic${index + 1}.jpg',
                                fit: BoxFit.cover,
                                width:
                                    45, // ensure the image fills the 60×60 circle
                                height: 45,
                              ),
                            ),
                          ),
                          title: Text(
                            messages[index]['name']!,
                            style: TextStyle(
                              color: Color(0xFF121417),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            messages[index]['msg']!,
                            style: TextStyle(
                              color: Color(0xFF637587),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Text(
                            messages[index]['time']!,
                            style: TextStyle(
                              color: Color(0xFF637587),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ],
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
}

