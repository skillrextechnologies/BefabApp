import 'package:befab/components/AddedItemsList.dart';
import 'package:befab/components/CaloriesMacroTracking.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/HeadingWithImageRow.dart';
import 'package:befab/components/MealTypeSelector.dart';
import 'package:befab/components/MetricsOverview.dart';
import 'package:befab/components/MetricsOverview2.dart';
import 'package:befab/components/SleepTracker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class MealLogging extends StatefulWidget {
  @override
  _MealLoggingState createState() => _MealLoggingState();
}

class _MealLoggingState extends State<MealLogging> {
  final List<MealOption> sampleMeals = [
    MealOption(
      name: 'Breakfast',
      calories: 320,
      selectedBgColor: Color(0xFFFFF0F0),
    ),
    MealOption(
      name: 'Lunch',
      calories: 480,
    ),
    MealOption(
      name: 'Dinner',
      calories: 450,
    ),
    MealOption(
      name: 'Snack',
      calories: 0,
    ),
  ];
  final List<AddedItem> sampleItems = [
    AddedItem.food(
      name: 'Scrambled Eggs',
      servingInfo: '2 Large Eggs',
      calories: 140,
      quantity: 2,
    ),
    AddedItem.food(
      name: 'Whole White Toast',
      servingInfo: '1 Slice',
      calories: 80,
      quantity: 1,
    ),
    
  ];
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      //   title: "Meal Logging",
      //   // rightWidget: Icon(Icons.more_vert, color: Colors.black),
      //   backgroundColor: Colors.white,
      // ),
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
              const SizedBox(width: 3),
              Text(
                'Back',
                style: GoogleFonts.inter(
                  color: Color(0xFF862633),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          'Meal Logging',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            MetricsOverview(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Meal Logging",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    "",
                    style: GoogleFonts.lexend(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            
            
            
            HeadingWithImageRow(
              heading: "Breakfast",
              subtitle: "320 calories",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 30,
                  color: Color(0xFF862633),
                ),
                onPressed:
                    () {},
              ),
            ),
            HeadingWithImageRow(
              heading: "Lunch",
              subtitle: "480 calories",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 30,
                  color: Color(0xFF862633),
                ),
                onPressed:
                    () {},
              ),
            ),
            HeadingWithImageRow(
              heading: "Dinner",
              subtitle: "450 calories",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 30,
                  color: Color(0xFF862633),
                ),
                onPressed:
                    () {},
              ),
            ),
            HeadingWithImageRow(
              heading: "Snack",
              subtitle: "0 calories",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 30,
                  color: Color(0xFF862633),
                ),
                onPressed:
                    () {},
              ),
            ),
            
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add Food Items",
                  style: GoogleFonts.lexend(
                          color: Color(0xFF000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEBEDF0),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search foods....",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF5E6B87),
                    ),
                    border: InputBorder.none,
                    isCollapsed: true, // removes extra vertical space
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ), // better vertical alignment
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF5E6B87),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity, // Makes the button take full width

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(
                        color: Color(0xFF862633), // Border color
                        width: 1,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBarcode(), // Ensure this has no padding/margin
                        // No SizedBox or spacing here
                        Text(
                          'Scan Barcode',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF862633),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity, // Makes the button take full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF862633),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text(
                      'Manual Entry',
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.w700, // Optional: make it a bit bolder
                        fontSize: 16, // Optional: specify a font size
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
ProgressTracker(
  title: 'Calories macro Tracking',
  leftText: '1250/2000 cal',
  rightText: '750 cal remaining',
  progress: 0.625, // 1250/2000
  progressColor: Color(0xFF862633), // Optional custom color

),
            MetricsOverview2(),

ProgressTracker(
  title: 'Hydration Tracker',
  leftText: '75%',
  rightText: '100%',
  progress: 0.75,
  progressColor: Color(0xFF862633), // Optional custom color
),
            
            
    
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity, // Makes the button take full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF862633),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text(
                      'Add Water',
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.w700, // Optional: make it a bit bolder
                        fontSize: 16, // Optional: specify a font size
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sleep Tracker",
                  style: GoogleFonts.lexend(
                          color: Color(0xFF000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                ),
              ),
            ),
            SleepTracker(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Wellness Tips",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFAFBFB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Mindful Eating",
                        style: TextStyle(
                          color: Color(0xFF862633),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Take time to enjoy your food without distractions. This help with digestion and prevents overeating",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24,)          ],
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
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}


Widget _buildBarcode() {
  return Container(
    height: 20,
    width: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBarcodeBar(width: 2, height: 25),
        SizedBox(width: 2),
        _buildBarcodeBar(width: 1, height: 30),
        SizedBox(width: 3),
        _buildBarcodeBar(width: 3, height: 20),
        SizedBox(width: 2),
        _buildBarcodeBar(width: 2, height: 25),
        SizedBox(width: 1),
        _buildBarcodeBar(width: 2, height: 25),
        SizedBox(width: 4),
        _buildBarcodeBar(width: 3, height: 30),
        SizedBox(width: 2),
        _buildBarcodeBar(width: 2, height: 20),
        SizedBox(width: 1),
        _buildBarcodeBar(width: 1, height: 25),
        SizedBox(width: 3),
        _buildBarcodeBar(width: 2, height: 25),
      ],
    ),
  );
}

Widget _buildBarcodeBar({required double width, required double height}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color(0xFF862633),
      borderRadius: BorderRadius.circular(0.5),
    ),
  );
}