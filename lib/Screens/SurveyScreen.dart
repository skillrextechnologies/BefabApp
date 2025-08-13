import 'package:befab/components/AssessmentCard.dart';
import 'package:befab/components/AssessmentItem.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum IconType { alert, clock, check, calendar, star, target }

class Surveyscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 36,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Surveys",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health Survey",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Complete surveys to help us personalize your fitness journey. Required Surveys help us track your progress.",
                    style: GoogleFonts.inter(
                      color: Color(0xFF9CA3AF),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Required Surveys",
                        style: GoogleFonts.lexend(
                          color: Color(0xFF121714),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          backgroundColor: Color(
                            0x1A862633,
                          ), // rgba(134, 38, 51, 0.1)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "2 Pending",
                          style: GoogleFonts.inter(
                            color: Color(0xFF862633),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AssessmentCard(
                  title: "Weekly fitness assessment",
                  subtitle: "Help us track your progress",
                  duration: "5 min.",
                  timeText: "due in 2 days",
                  buttonText: "Start Survey",
                  image: "assets/images/alert.svg",
                  onButtonPressed: () {
                    print("Health checkup started");
                  },
                ),
                AssessmentCard(
                  title: "Nutrition Tracking",
                  subtitle: "Help us track your progress",
                  duration: "5 min.",
                  timeText: "due in 2 days",
                  buttonText: "Start Survey",
                  image: "assets/images/alert.svg",

                  onButtonPressed: () {
                    // Handle button press
                    print("Health checkup started");
                  },
                ),
              ],
            ),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Optional Surveys",
                        style: GoogleFonts.lexend(
                          color: Color(0xFF121714),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          backgroundColor: Color(
                            0x1A862633,
                          ), // rgba(134, 38, 51, 0.1)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child:  Text(
                          "3 available",
                          style: GoogleFonts.inter(
                            color: Color(0xFF862633),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AssessmentCard(
                  title: "Sleep Quality",
                  subtitle: "Improve your recovery with better sleep",
                  duration: "5 min.",
                  timeText: "due in 2 days",
                  buttonText: "Start Survey",
                  image: "assets/images/noon.svg",

                  onButtonPressed: () {
                    print("Health checkup started");
                  },
                ),
                AssessmentCard(
                  title: "Workout Prefrences",
                  subtitle: "Customize your workout experience",
                  duration: "5 min.",
                  timeText: "due in 2 days",
                  image: "assets/images/dumbell2.svg",

                  buttonText: "Start Survey",
                  onButtonPressed: () {
                    // Handle button press
                    print("Health checkup started");
                  },
                ),
                AssessmentCard(
                  title: "Mental Wellness",
                  subtitle: "Help us track your Mental health journey",
                  duration: "5 min.",
                  timeText: "due in 2 days",
                  buttonText: "Start Survey",
                  image: "assets/images/dumbell2.svg",
                  onButtonPressed: () {
                    // Handle button press
                    print("Health checkup started");
                  },
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Past Surveys",
                    style: GoogleFonts.lexend(
                            color: Color(0xFF121714),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    "view all",
                    style: GoogleFonts.lexend(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            AssessmentItem(
              title: "Weekly fitness assessment",
              statusText: "Completed on 17, 2025",
              status: AssessmentStatus.inProgress,
              onTap: () {
                print("In progress assessment tapped");
              },
            ),
            AssessmentItem(
              title: "Nutrition Tracking",
              statusText: "Completed on 17, 2025",
              status: AssessmentStatus.inProgress,
              onTap: () {
                print("In progress assessment tapped");
              },
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

