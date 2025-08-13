// single_video_screen.dart
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class SingleVideoScreen extends StatelessWidget {
  const SingleVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,  // Prevent M3 tint

        elevation: 0,
        leadingWidth: 100, // Give more width to accommodate icon + text
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
                  'assets/images/Arrow2.svg',
                  width: 14,
                  height: 14,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Fitness New',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/video_thumb4.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 5,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile2.jpg',),
                  radius: 24,
                ),
                SizedBox(height: 16),
                SvgPicture.asset('assets/images/message2.svg', width: 24, height: 24),
                Text('22', style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                SvgPicture.asset(
                  'assets/images/heart2.svg',
                  width: 24,
                  height: 24,
                ),
                Text('15', style: TextStyle(color: Colors.white)),
                                SizedBox(height: 16),

                SvgPicture.asset(
                  'assets/images/Primary.svg',
                  width: 24,
                  height: 24,
                ),
                Text('1', style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                SvgPicture.asset('assets/images/option.svg', width: 12, height: 12),
              ],
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
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
    );
  }
}

