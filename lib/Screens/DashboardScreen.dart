// dashboard_screen.dart
import 'package:befab/Screens/NewGoalEntryForm.dart';
import 'package:befab/charts/WeightLossProgressChart.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: CustomDrawer(
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,         // Solid white
  elevation: 0,                          // No shadow
  surfaceTintColor: Colors.transparent,  // Prevent M3 tint
  iconTheme: IconThemeData(color: Color(0xFF862633)),
        title: Row(
          children: [
             CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'Hi, John',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 2),
                Text(
                  'Good Evening',
                  style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w400, color: Color(0xFF9C9B9D)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/bell.svg', // replace with your bell image path
                  height: 24,
                  width: 24,
                  color: Color(0xFF862633),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            WeightLossProgressChart(),
            // _buildWeightLossProgressCard(),
            SizedBox(height: 16),
            _buildActivityTrackerCard(context),
            const SizedBox(height: 12),
            Card(
              color: Color(0xFFF3F3F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                    child: Text(
                      'Goals Summary',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildGoalRow("Goal Title", "Description", "30%"),
                  ),
                  Divider(thickness: 0.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildGoalRow("Goal Title", "Description", "50%"),
                  ),
                  Divider(thickness: 0.5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,right: 8),
                      child: Text(
                        "view all",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildImageCard(
                  "assets/images/mail.svg",
                  "E-Newsletters",
                  "23 new",
                ),
                _buildImageCard(
                  "assets/images/video2.svg",
                  "Videos",
                  "5 trending",
                ),
                _buildImageCard("assets/images/sms.svg", "SMS", "4 unread"),
                _buildImageCard(
                  "assets/images/groups2.svg",
                  "Group",
                  "10 invitations",
                ),
                _buildImageCard(
                  "assets/images/groups2.svg",
                  "Competitors",
                  "view more",
                ),
                _buildImageCard(
                  "assets/images/activities2.svg",
                  "Activities",
                  "view more",
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(padding: const EdgeInsets.all(8.0), child: Text("More",style: TextStyle(fontSize:15,fontWeight: FontWeight.w400 ),)),
            const SizedBox(height: 12),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              _buildIconBoxWithText('assets/images/log.svg', 'Log Activity',"",context,null),
            _buildIconBoxWithText('assets/images/goal.svg', 'Set a Goal',"new-goal",context,NewGoalPage()),
            _buildIconBoxWithText(
              'assets/images/competition2.svg',
              'Join Competition',""
            ,context,null),
            _buildIconBoxWithText('assets/images/resource.svg', 'Resource',"",context,null),
              ],
            ),
            SizedBox(height: 8),
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
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
    );
  }
}

Widget _buildGoalRow(String title, String subtitle, String percent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14)),
            SizedBox(height: 4),
            Text(subtitle, style: GoogleFonts.inter(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 13)),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Text(percent, style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w400)),
        ),
      ],
    ),
  );
}

Widget _buildIconBoxWithText(String imagePath, String label, String url, BuildContext context,  Widget? targetPage, ) {
  return GestureDetector(
    onTap: () {
      if (url.isNotEmpty) {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => targetPage!),
);
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(imagePath, fit: BoxFit.contain),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 36),
      ],
    ),
  );
}


Widget _buildImageCard(String imagePath, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 80,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(imagePath, width: 32, height: 32, fit: BoxFit.contain),
          SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.black,fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: Colors.grey,fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


Widget _buildSegmentButton(String label, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: isSelected ? Color(0xFFD9D9D9) : Color(0xFFF3F3F3),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'roboto',
        color: isSelected ? Color(0xFF1D1B20) : Color(0xFF49454F),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildActivityTrackerCard(BuildContext context) {
    double progress = 0.7; // 70%

  return Card(
    color: Color(0xFFF3F3F3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                'Physical activity tracker',
                style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Icon(Icons.keyboard_arrow_up),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildSegmentButton("Daily", true),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: _buildSegmentButton("Weekly", false),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: _buildSegmentButton("Monthly", false),
              ),
            ],
          ),
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF862633),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Percentages below the bar
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("0%",style: GoogleFonts.inter(color: Color(0xFF4E4E4E),fontSize: 13,
                        fontWeight: FontWeight.w400,),),
                      Text("100%",style: GoogleFonts.inter(color: Color(0xFF4E4E4E),fontSize: 13,
                        fontWeight: FontWeight.w400,)),
                    ],
                  ),
                  Positioned(
                    left: progress * MediaQuery.of(context).size.width * 0.72,
                    child: Text(
                      "${(progress * 100).round()}%",
                      style:  GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4E4E4E),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "view details",
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Color(0xFF862633),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

