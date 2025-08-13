import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class AllNewslettersScreen extends StatelessWidget {
  const AllNewslettersScreen({super.key});

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
        title: const Text(
          'All Newsletter',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16, // Same as Back text
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding:  EdgeInsets.all(16),
            child: Column(
  children: List.generate(3, (index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/single-newsletter');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/news_banner${index + 1}.png',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Headline',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'One answer is that Truth pertains to the possibility that an event will occur. If true – it must occur and if false, it cannot occur...',
              style: GoogleFonts.inter(
                color: Color(0xFF9C9B9D),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Published By:',
                  style: GoogleFonts.inter(
                    color: Color(0xFF000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/single-newsletter');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Chip(
                    backgroundColor: const Color(0x1A862633),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    label: Text(
                      'Read',
                      style: GoogleFonts.inter(
                        color: Color(0xFF862633),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
                );
              }),
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
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
    );
  }
}

