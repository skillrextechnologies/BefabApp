
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/GroupComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class GroupsPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
          surfaceTintColor: Colors.transparent,  // Prevent M3 tint

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
        title: const Text('Groups', style: TextStyle(color: Colors.black,fontSize: 16)),

        /// 👉 Add Settings Icon to the trailing side
        actions: [
          

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children:[
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
                      hintText: "Search groups",
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
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Discover Groups",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
              GroupCard(
          groupImage: 'assets/images/cat.png',
          groupName: 'Sweat & Smile',
          groupType: 'Public group',
          postedTime: '2d',
          membersCount: '3.3k',
          description: 'A place for cat lovers in the Bay Area to connect and share cute photos.',
          imageUrls: [
            'assets/images/photo1.png',
            'assets/images/photo2.png',
            'assets/images/photo3.png',
            'assets/images/photo4.png',
          ],
          onJoinPressed: () {
            print('Join button pressed!');
          },
        ),
           GroupCard(
          groupImage: 'assets/images/dog.png',
          groupName: 'Sweat & Smile',
          groupType: 'Public group',
          postedTime: '2d',
          membersCount: '3.3k',
          description: 'A place for cat lovers in the Bay Area to connect and share cute photos.',
          imageUrls: [
            'assets/images/photo5.png',
            'assets/images/photo6.png',
            'assets/images/photo7.png',
            'assets/images/photo8.png',
          ],
          onJoinPressed: () {
            print('Join button pressed!');
          },
        ),
        GroupCard(
          groupImage: 'assets/images/shell.png',
          groupName: 'Sweat & Smile',
          groupType: 'Public group',
          postedTime: '2d',
          membersCount: '3.3k',
          description: 'A place for cat lovers in the Bay Area to connect and share cute photos.',
          imageUrls: [
            'assets/images/photo1.png',
            'assets/images/photo2.png',
            'assets/images/photo3.png',
            'assets/images/photo4.png',
          ],
          onJoinPressed: () {
            print('Join button pressed!');
          },
        ),
        
        ]
                ),
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
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),    );
  }
}
