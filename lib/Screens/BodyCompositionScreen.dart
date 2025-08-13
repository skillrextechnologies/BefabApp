import 'package:befab/charts/BodyCompositionChart.dart';
import 'package:befab/charts/WeightTrackingChart.dart';
import 'package:befab/components/ActivityStatCard.dart';
import 'package:befab/components/CustomAppHeader.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/HealthStatusCard.dart';
import 'package:befab/components/StatusCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class BodyCompositionScreen extends StatelessWidget {
  final allItems = [
    CompositionItem(
      label: 'Lean Body Mass (76%)',
      percentage: 76.0,
      color: Color(0xFF8B2635),
    ),
    CompositionItem(
      label: 'Body Fat',
      percentage: 24.0,
      color: Color.fromRGBO(134, 38, 51, 0.6),
    ),
    CompositionItem(
      label: 'Body Mass (56%)',
      percentage: 55.0,
      color: Color.fromRGBO(134, 38, 51, 0.4),
    ),
    CompositionItem(
      label: 'Body Mass (56%)',
      percentage: 10.0,
      color: Color.fromRGBO(134, 38, 51, 0.2),
    ),
  ];

  final List<HealthStat> healthStats = [
    HealthStat(
      title: "Weight",
      value: "68.5",
      unit: "kg",
      lastUpdated: "4h ago",
      secondaryLabel: "-0.12 kg from last month",
      secondaryColor: Color(0xFF16A34A),
    ),
    HealthStat(
      title: "Height",
      value: "175",
      unit: "cm",
      lastUpdated: "2 mon ago",
    ),
    HealthStat(
      title: "BMI",
      value: "22.4",
      unit: "",
      lastUpdated: "today",
      secondaryLabel: "Normal weight",
      secondaryColor: Color(0xFF16A34A),
    ),
    HealthStat(
      title: "Body Fat Percent",
      value: "68.5",
      unit: "kg",
      lastUpdated: "today",
      secondaryLabel: "Healthy Range",
      secondaryColor: Color(0xFF16A34A),
    ),
    HealthStat(
      title: "Lean Body Mass",
      value: "52.1",
      unit: "kg",
      lastUpdated: "today",
    ),
    HealthStat(
      title: "Bone Mass",
      value: "3.2",
      unit: "kg",
      lastUpdated: "today",
    ),
    HealthStat(
      title: "Bone Water Mass",
      value: "37.5",
      unit: "kg",
      lastUpdated: "today",
      secondaryLabel: "56% of body weight",
      secondaryColor: Color(0xFF878686),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leftWidget: Row(
          children: [
            SvgPicture.asset('assets/images/Arrow.svg', width: 14, height: 14),
            SizedBox(width: 4),
            Text(
              "Back",
              style: TextStyle(
                color: Color(0xFF862633),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        onLeftTap: () => Navigator.pop(context),
        title: "Body composition",
        rightWidget: Icon(Icons.more_vert, color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: WeightTrackingChart(
                title: 'Current Weight',
                currentWeight: '68',
                weightUnit: 'KG',
                changeText: '-12.6 kg',
                isWeightLoss: true,
                chartData: const [
                  ChartDataPoint(label: 'May 1', value: 75.0),
                  ChartDataPoint(label: 'May 15', value: 73.5),
                  ChartDataPoint(label: 'Jun 1', value: 71.0),
                  ChartDataPoint(label: 'Jun 15', value: 69.5),
                  ChartDataPoint(label: 'Today', value: 68.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/cal.svg",
                      imageColor: Color(0xFFFF7D0E),
                      imageBackgroundColor: Color.fromRGBO(255, 125, 14, 0.2),
                      title: "BMI",
                      value: "5.2",
                      unit: "km",
                      goalLabel: "Normal weight",
                      progress: 5.2 / 8.0,
                      startLabel: '18.5',
                      endLabel: '25',
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/men.svg",
                      imageColor: Color(0xFF2563EB),
                      imageBackgroundColor: Color.fromRGBO(37, 99, 235, 0.2),
                      title: "Body Fat",
                      value: "24%",
                      unit: "",
                      goalLabel: "Healthy range",
                      progress: 12 / 15,
                      startLabel: '14%',
                      endLabel: '31%',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Other Vital Metrics",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            HealthStatusCard(stats: healthStats),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Body Composition Analysis",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            BodyCompositionChart(
              chartItems: allItems.sublist(0, 2), // only 2 shown in chart
              legendItems: allItems, // all shown in legend
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Recommendation",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF), // background color
                  border: Border.all(
                    color: Color(0xFFF3F4F6), // border color (light grey)
                    width: 1, // optional border width
                  ),
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // optional: rounded corners
                ),
                child: Column(
                  children: [
                    StatusCard(
                      heading: 'Your BMI is in the healthy range',
                      subText:
                          'Maintain your current weight through balanced diet and regular exercise.',
                      image:
                          "assets/images/cal.svg", // Replace with any icon you need
                      imageColor: Color(0xFFFF1919),
                      imageBgColor: Color.fromRGBO(255, 25, 25, 0.2),
                    ),
                    StatusCard(
                      heading: 'Consider strength training',
                      subText:
                          'To increase your lean body mass and improve overall fitness.',
                      image:
                          "assets/images/dumbell.svg", // Replace with any icon you need
                      imageColor: Color(0xFF0074C4),
                      imageBgColor: Color.fromRGBO(0, 116, 196, 0.2),
                    ),
                    StatusCard(
                      heading: 'Stay hydrated',
                      subText:
                          'Your body water percentage is good, aim to drink 2-3 liters daily.',
                      image:
                          "assets/images/droplets.svg", // Replace with any icon you need
                      imageColor: Color(0xFF0CBFAD),
                      imageBgColor: Color.fromRGBO(12, 191, 173, 0.2),
                    ),

                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
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
                      'Add New Measurement',
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.w600, // Optional: make it a bit bolder
                        fontSize: 16, // Optional: specify a font size
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 36),
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
