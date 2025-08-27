// dashboard_screen.dart
import 'dart:convert';
import 'package:befab/Screens/NewGoalEntryForm.dart';
import 'package:befab/charts/WeightLossProgressChart.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/CustomDrawer.dart';
import 'package:befab/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final storage = const FlutterSecureStorage();

  String firstName = "";
  String lastName = "";
  String profilePhoto = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final token = await secureStorage.read(key: 'token');
      final url = "${dotenv.env['BACKEND_URL']}/app/get";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          firstName = data["firstName"] ?? "";
          lastName = data["lastName"] ?? "";
          profilePhoto = data["profilePhoto"] ?? "";
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching user: $e");
      setState(() => isLoading = false);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    final fallbackAvatar = "${dotenv.env['BACKEND_URL']}/BeFab.png";
    final avatarUrl =
        profilePhoto.isNotEmpty ? "${dotenv.env['BACKEND_URL']}/$profilePhoto" : fallbackAvatar;

    return Scaffold(
      drawer: CustomDrawer(userName: "$firstName $lastName",
    profileImage: avatarUrl),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF862633)),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLoading ? "Loading..." : "Hi, $firstName $lastName",
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 2),
                Text(
                  _getGreeting(),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9C9B9D),
                  ),
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
                  'assets/images/bell.svg',
                  height: 24,
                  width: 24,
                  color: const Color(0xFF862633),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
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

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  WeightLossProgressChart(),
                  const SizedBox(height: 16),
                  _buildActivityTrackerCard(context),
                  const SizedBox(height: 12),
                  Card(
                    color: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            'Goals Summary',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildGoalRow("Goal Title", "Description", "30%"),
                        ),
                        const Divider(thickness: 0.5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildGoalRow("Goal Title", "Description", "50%"),
                        ),
                        const Divider(thickness: 0.5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                            child: const Text(
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
  _buildImageCard(context, "assets/images/mail.svg", "E-Newsletters", "", "/all-newsletters"),
  _buildImageCard(context, "assets/images/video2.svg", "Videos", "", "/video-categories"),
  _buildImageCard(context, "assets/images/sms.svg", "SMS", "", "/message"),
  _buildImageCard(context, "assets/images/groups2.svg", "Group", "", "/groups"),
  _buildImageCard(context, "assets/images/groups2.svg", "Competitions", "", "/competitions-list"),
  _buildImageCard(context, "assets/images/activities2.svg", "Activities", "", "/nutrition"),
],


                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("More",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
  _buildIconBoxWithText(context, 'assets/images/log.svg', 'Log Activity', "/log"),
  _buildIconBoxWithText(context, 'assets/images/goal.svg', 'Set a Goal', "/new-goal"),
  _buildIconBoxWithText(context, 'assets/images/competition2.svg', 'Join Competition', "/competitions-list"),
  _buildIconBoxWithText(context, 'assets/images/resource.svg', 'Resource', "/dashboard"),
],

                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: IconButton(
          icon: const Icon(Icons.add_circle, size: 70, color: Color(0xFF862633)),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
    );
  }
}

// ----------------- UI Helpers -------------------

Widget _buildGoalRow(String title, String subtitle, String percent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: GoogleFonts.inter(
                    color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 13)),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
          child: Text(percent,
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),
        ),
      ],
    ),
  );
}
Widget _buildIconBoxWithText(
    BuildContext context, String imagePath, String label, String route) {
  return GestureDetector(
    onTap: () {
      if (route.isNotEmpty) {
        Navigator.pushNamed(context, route); // ✅ navigate by route
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),
        const SizedBox(height: 36),
      ],
    ),
  );
}

Widget _buildImageCard(
    BuildContext context, String imagePath, String title, String subtitle, String route) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        if (route.isNotEmpty) {
          Navigator.pushNamed(context, route); // ✅ use context here
        }
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(imagePath,
                width: 32, height: 32, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}


Widget _buildSegmentButton(String label, bool isSelected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: isSelected ? const Color(0xFFD9D9D9) : const Color(0xFFF3F3F3),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    ),
    child: Text(label,
        style: TextStyle(
          fontFamily: 'roboto',
          color: isSelected ? const Color(0xFF1D1B20) : const Color(0xFF49454F),
          fontWeight: FontWeight.w600,
        )),
  );
}

Widget _buildActivityTrackerCard(BuildContext context) {
  double progress = 0.7;

  return Card(
    color: const Color(0xFFF3F3F3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Physical activity tracker',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16)),
              const Icon(Icons.keyboard_arrow_up),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildSegmentButton("Daily", true),
              const SizedBox(width: 12),
              _buildSegmentButton("Weekly", false),
              const SizedBox(width: 12),
              _buildSegmentButton("Monthly", false),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12)),
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
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("0%",
                          style: GoogleFonts.inter(
                              color: const Color(0xFF4E4E4E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400)),
                      Text("100%",
                          style: GoogleFonts.inter(
                              color: const Color(0xFF4E4E4E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Positioned(
                    left: progress * MediaQuery.of(context).size.width * 0.72,
                    child: Text("${(progress * 100).round()}%",
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4E4E4E))),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerRight,
            child: Text("view details",
                style: TextStyle(fontSize: 11, color: Color(0xFF862633))),
          ),
        ],
      ),
    ),
  );
}
