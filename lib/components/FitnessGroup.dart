import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class FitnessGroupPage extends StatefulWidget {
  @override
  _FitnessGroupPageState createState() => _FitnessGroupPageState();
}

class _FitnessGroupPageState extends State<FitnessGroupPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: const Text(
          'Groups',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),

        /// 👉 Add Settings Icon to the trailing side
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Background banner image
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/news_banner1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Positioned profile avatar
                    Positioned(
                      bottom: -45, // overlap by 45 pixels
                      left: 20,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[300],
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/cat.png",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 55,
                ), // Space to accommodate the overlapping avatar
              ],
            ),

            // Group Details Section
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Group Avatar
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sweat & Smile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/globe.svg",
                                  color: Color(0xFF5E6B87),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Public group • 2d',
                                  style: TextStyle(
                                    color: Color(0xFF5E6B87),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '3.3k Members',
                              style: TextStyle(
                                color: Color(0xFF5E6B87),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF862633),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                        ),
                        child: Text('Join'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'A place for fitness enthusiasts in the Bay Area to connect, share workouts, and motivate each other.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5E6B87),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Divider(),
            ),
            // Stats Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem('156', 'Posts'),
                  _buildStatItem('3.3k', 'Members'),
                  _buildStatItem('89', 'Photos'),
                ],
              ),
            ),

            // Tab Navigation
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: Row(
                children: [
                  _buildTabItem('Posts', 0),
                  _buildTabItem('Photos', 1),
                  _buildTabItem('Members', 2),
                  _buildTabItem('Events', 3),
                ],
              ),
            ),

            // Content Area
            Container(
              height: 400, // Fixed height for scrollable content
              child: _buildTabContent(),
            ),
          ],
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
          onPressed:
              (){},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Color(0xFF862633) : Color(0xFFBABABA),
                width: 1,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Color(0xFF862633) : Color(0xFF5E6B87),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildPostsTab();
      case 1:
        return _buildPhotosTab();
      case 2:
        return _buildMembersTab();
      case 3:
        return _buildEventsTab();
      default:
        return _buildPostsTab();
    }
  }

  Widget _buildPostsTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        SocialPostCard(
          profileImage:
              'assets/images/dog.png', // Can be used for actual image URL
          groupName: 'Squat Squad',
          timeAgo: '1h •',
          postText:
              'A place for cat lovers in the Bay Area to connect and share',
        ),
        SizedBox(height: 16),
        // Add more posts here
      ],
    );
  }

  Widget _buildPhotosTab() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.fitness_center, color: Colors.grey[600], size: 40),
        );
      },
    );
  }

  Widget _buildMembersTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600]),
          ),
          title: Text('Member ${index + 1}'),
          subtitle: Text('Fitness enthusiast'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildEventsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red[700],
              child: Icon(Icons.event, color: Colors.white),
            ),
            title: Text('Morning Run Session'),
            subtitle: Text('Tomorrow at 7:00 AM'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class SocialPostCard extends StatelessWidget {
  final String profileImage;
  final String groupName;
  final String timeAgo;
  final String postText;

  const SocialPostCard({
    super.key,
    required this.profileImage,
    required this.groupName,
    required this.timeAgo,
    required this.postText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Ensures vertical alignment
      children: [
        // Profile image
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.asset(
              profileImage,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12), // Spacing between image and text
        // Group name and time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                groupName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5E6B87),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.public, size: 16, color: Color(0xFF5E6B87)),
                ],
              ),
            ],
          ),
        ),
        // More options button (you can replace with IconButton or similar)
Container()      ],
    ),
    const SizedBox(height: 12),
    // Post text
    Text(
      postText,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        height: 1.4,
      ),
    ),
  ],
)

    );
  }
}
