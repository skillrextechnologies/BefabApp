import 'package:befab/charts/HydrationTrackerWidget.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/HeadingWithImageRow.dart';
import 'package:befab/components/WeeklyStatusWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

import 'package:flutter/material.dart';

class HydrationTracker extends StatefulWidget {
  @override
  _HydrationTrackerState createState() => _HydrationTrackerState();
}

class _HydrationTrackerState extends State<HydrationTracker> {
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
          'Hydration Tracker',
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
            HydrationTrackerWidget(
              title: "Today's Hydration",
              consumedAmount: 1000,
              dailyGoal: 2000,
              currentCups: 4,
              totalCups: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Quick Add",
                    style: GoogleFonts.lexend(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFBFB)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("100 ml",style: TextStyle(color: Color(0xFF862633,),fontSize: 16,fontWeight: FontWeight.w600),),
                  )),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFBFB)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("250 ml",style: TextStyle(color: Color(0xFF862633,),fontSize: 16,fontWeight: FontWeight.w600),),
                  )),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFBFB)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("500 ml",style: TextStyle(color: Color(0xFF862633,),fontSize: 16,fontWeight: FontWeight.w600),),
                  )),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFBFB)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Custom",style: TextStyle(color: Color(0xFF862633,),fontSize: 16,fontWeight: FontWeight.w600),),
                  )),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Today’s Log",
                    style: GoogleFonts.lexend(
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
              heading: "250 ml",
              subtitle: "8:30 am",
trailingWidget: SvgPicture.asset("assets/images/bin.svg",color: Color(0xFFFF1919),),            ),
            HeadingWithImageRow(
              heading: "500 ml",
              subtitle: "11:30 am",
trailingWidget: SvgPicture.asset("assets/images/bin.svg",color: Color(0xFFFF1919),),            ),
            HeadingWithImageRow(
              heading: "150 ml",
              subtitle: "2:50 pm",
trailingWidget: SvgPicture.asset("assets/images/bin.svg",color: Color(0xFFFF1919),),            ),
            HeadingWithImageRow(
              heading: "100 ml",
              subtitle: "4:20 pm",
              trailingWidget: SvgPicture.asset("assets/images/bin.svg",color: Color(0xFFFF1919),),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Meal Breakdown",
                    style: GoogleFonts.lexend(
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
            WeeklyStatusWidget(
              title: 'Weekly Status',
              viewAllText: 'View all',
              weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              averageLabel: 'Average',
              averageValue: '1750',
              averageUnit: 'ml',
              goalLabel: 'Goal',
              goalValue: '2000',
              goalUnit: 'ml',
              onViewAllTap: () {
                print('View all tapped');
              },
              titleColor: const Color(0xFF862633),
              viewAllColor: const Color(0xFF862633),
              averageColor: const Color(0xFF862633),
              goalColor: const Color(0xFF862633),
              backgroundColor: Color(0xFFFAFBFB),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hydration Tips",
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
                        "Good Protein intake",
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
                        "You are meeting your proteins goals, which is great for muscles maintainence and recovery",
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
            SizedBox(height: 24,)
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
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}

