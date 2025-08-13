// video_categories_screen.dart
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class VideoCategoriesScreen extends StatelessWidget {
  const VideoCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,         // Solid white
  elevation: 0,                          // No shadow
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
          'Videos Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16, // Same as Back text
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Stack(
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleButtonsRow(),
        Expanded(
  child: GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 0.55,
    padding: const EdgeInsets.all(16),
    children: List.generate(
      4,
      (index) => GestureDetector(
        onTap: () {
        Navigator.pushNamed(context, '/single-video');
      },
        child: Container(
          margin: const EdgeInsets.all(4), // Optional spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/video_thumb${index + 1}.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 3),
               Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(
                      'assets/images/profile2.jpg',
                    ),
                  ),
                  const SizedBox(width: 3),
                   Text(
                    'Samantha',
                    style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/like.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 3),
        
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: const Text(
                      '220',
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ),
)

      ],
    ),
  ],
)
,
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


class ToggleButtonsRow extends StatefulWidget {
  const ToggleButtonsRow({super.key});

  @override
  State<ToggleButtonsRow> createState() => _ToggleButtonsRowState();
}

class _ToggleButtonsRowState extends State<ToggleButtonsRow> {
  String selected = 'BeFAB HBCU'; // default selected

  final List<String> labels = ['BeFAB HBCU', 'Mentor Meetup', 'Students'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 48, // Increased height
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFFC7C7CC)),
          ),
          child: Row(
            children:
                labels.map((label) {
                  final isSelected = selected == label;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = label;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ), // Slightly reduced
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? const Color(0xFF862633)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color(0xFF862633)
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isSelected ? 15 : 14,
                            color:
                                isSelected ? Colors.white : Color(0xFF9C9B9D),
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
