// dashboard_screen.dart
import 'package:befab/charts/WeeklyActivityChart.dart';
import 'package:befab/components/CustomAppHeader.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/ImageTextGridCard.dart';
import 'package:befab/components/MiniStatCard.dart';
import 'package:befab/components/VitalsCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class FitnessSummary extends StatelessWidget {
  const FitnessSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leftWidget: Row(
          children: [
            SvgPicture.asset('assets/images/Arrow.svg', width: 14, height: 14),
            SizedBox(width: 4),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Hi, John',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Good Evening',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        onLeftTap: () => Navigator.pop(context),
        // title: "Body composition",
        rightWidget: SvgPicture.asset("assets/images/settings2.svg"),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Todays Summary",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    "See All",
                    style: GoogleFonts.inter(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            MiniStatsGrid(),
            
            WeeklyActivityChart(
              title: 'Weekly Activity',
              stepsData: [8500, 9200, 7800, 10200, 9800, 8900, 9500],
              caloriesData: [320, 380, 290, 420, 390, 350, 370],
            ),
Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Heath Categories",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    "",
                    style: GoogleFonts.inter(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            VitalsCard(
              icon: "assets/images/vital.svg",
              iconBgColor: Color.fromRGBO(22, 163, 74, 0.2),
              iconColor: Color(0xFF16A34A), // Optional, not currently used
              heading: 'Vitals',
              vitals: const [
                {'label': 'Sleep', 'value': '72h 20m'},
                {'label': 'Distance', 'value': '5.2 Km'},
                {'label': 'Active Calories', 'value': '425 Kcal'},
                {'label': 'Activity Minutes', 'value': '58 min'},
              ],
            ),

            VitalsCard(
              icon: "assets/images/heartbeat.svg",
              iconBgColor: Color.fromRGBO(221, 37, 37, 0.2),
              iconColor: Color(0xFFDD2525), // Optional, not currently used
              heading: 'Vitals',
              vitals: const [
                {'label': 'Heart Rate', 'value': '72h 20m'},
                {'label': 'Blood Pressure', 'value': '5.2 Km'},
                {'label': 'Oxygen (sp02)', 'value': '98%'},
                {'label': 'Respiratory Rate', 'value': '16 rpm'},
              ],
            ),

            VitalsCard(
              icon: "assets/images/body.svg",
              iconBgColor: Color.fromRGBO(37, 99, 235, 0.2),
              iconColor: Color(0xFF0074C4), // Optional, not currently used
              heading: 'Body Composition',
              vitals: const [
                {'label': 'Weight', 'value': '68.5 Kg'},
                {'label': 'BMI', 'value': '22.4'},
                {'label': 'Body Fat', 'value': '24%'},
                {'label': 'Lean Mass', 'value': '52.2 Kg'},
              ],
            ),

            VitalsCard(
              icon: "assets/images/moon.svg",
              iconBgColor: Color.fromRGBO(147, 51, 234, 0.2),
              iconColor: Color(0xFF9333EA), // Optional, not currently used
              heading: 'Sleep',
              vitals: const [
                {'label': 'Duration', 'value': '1h 45m'},
                {'label': 'Deep sleep', 'value': '5.2 Km'},
                {'label': 'Rem Sleep', 'value': '1h 32m'},
                {'label': 'Sleep Quality', 'value': 'Good'},
              ],
            ),


            ImageTextGridItemCards(
  items: [
    {
      'image':  SvgPicture.asset('assets/images/cycle.svg',color: Color(0xFF9333EA),),

      'text': 'Cycle Tracking',
      'imageBgColor': Color.fromRGBO(147, 51, 234, 0.2),
    },
    {
      'image':  SvgPicture.asset('assets/images/run2.svg'),
      'text': 'Mobility',
      'imageBgColor': Color.fromRGBO(22, 163, 74, 0.2),
    },
    {
      'image':  SvgPicture.asset('assets/images/heart3.svg'),
      'text': 'Health Records',
      'imageBgColor': Color.fromRGBO(249, 115, 22, 0.2),
    },
    {
      'image':  SvgPicture.asset('assets/images/option.svg'),
      'text': 'Cycle Tracking',
      'imageBgColor': Colors.white,
    },
  ],
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

