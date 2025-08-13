import 'package:befab/charts/ActivityTrackerWidget.dart';
import 'package:befab/charts/WeeklyActivityChart2.dart';
import 'package:befab/components/ActivityCard.dart';
import 'package:befab/components/ActivityMetric.dart';
import 'package:befab/components/ActivityStatCard.dart';
import 'package:befab/components/CustomAppHeader.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class ActivityFitness extends StatefulWidget {
  @override
  _ActivityFitnessState createState() => _ActivityFitnessState();
}

class _ActivityFitnessState extends State<ActivityFitness> {
  final List<ActivityMetric> sampleMetrics = [
    ActivityMetric(
      image: "assets/images/cycle.svg",
      iconBackgroundColor: const Color.fromRGBO(0, 184, 68, 0.2),
      iconColor: const Color(0xFF00B844),
      title: 'Cycling',
      subtitle: 'Distance',
      value: '5.2',
      unit: 'km',
      description: 'Weekly Total',
    ),
    ActivityMetric(
      image: "assets/images/ic4.svg",
      iconBackgroundColor: const Color.fromRGBO(255, 149, 0, 0.2),
      iconColor: const Color(0xFFFF9500),
      title: 'Wheelchair',
      subtitle: 'Pushes',
      value: 'N/A',
      unit: '',
      description: 'Not Tracked',
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
        title: "Activity Fitness",
        // rightWidget: Icon(Icons.more_vert, color: Colors.black),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ActivityTrackerWidget(
              title: "Today's Activity",
              date: "May 24, 2024",
              currentValue: 8543,
              unit: "Steps",
              goalValue: 10000,
              progressPercentage: 85.0,
              averageValue: 8192,
              progressColor: const Color(0xFF8B4B5C),
              backgroundColor: const Color(0xFFE5E5E5),
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
                      image: "assets/images/ic1.svg",
                      imageColor: Color(0xFF862633),
                      imageBackgroundColor: Color.fromRGBO(134, 38, 51, 0.2),
                      title: "BMI",
                      value: "5.2",
                      unit: "km",
                      goalLabel: "Normal weight",
                      progress: 5.2 / 8.0,
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/ic2.svg",
                      imageColor: Color(0xFF2563EB),
                      imageBackgroundColor: Color.fromRGBO(37, 99, 235, 0.2),
                      title: "Body Fat",
                      value: "24%",
                      unit: "",
                      goalLabel: "Healthy range",
                      progress: 12 / 15,
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/fire.svg",
                      imageColor: Color(0xFF16A34A),
                      imageBackgroundColor: Color.fromRGBO(22, 163, 74, 0.2),
                      title: "BMI",
                      value: "5.2",
                      unit: "km",
                      goalLabel: "Normal weight",
                      progress: 5.2 / 8.0,
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/ic3.svg",
                      imageColor: Color(0xFF9333EA),
                      imageBackgroundColor: Color.fromRGBO(147, 51, 234, 0.2),
                      title: "Body Fat",
                      value: "24%",
                      unit: "",
                      goalLabel: "Healthy range",
                      progress: 12 / 15,
                    ),
                  ),
                ],
              ),
            ),
            WeeklyActivityChart2(
              title: 'Activity Minutes',
              stepsData: [8500, 9200, 7800, 10200, 9800, 8900, 9500],
              caloriesData: [320, 380, 290, 420, 390, 350, 370],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Recent Workout",
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
            ActivityCard(
              image: "assets/images/activities3.svg",
              iconColor: Color(0xFF0074C4),
              iconBackgroundColor: Color.fromRGBO(0, 116, 196, 0.2),
              title: 'Morning Run',
              subtitle: 'Today 7:30 AM',
              metric1Label: 'Distance',
              metric1Value: '3.2 km',
              metric2Label: 'Duration',
              metric2Value: '28 min',
              metric3Label: 'Calories',
              metric3Value: '234 kcal',
              isTrue: false,
            ),
            ActivityCard(
              image: "assets/images/cyclist.svg",
              iconColor: Color(0xFF862633),
              iconBackgroundColor: Color.fromRGBO(134, 38, 51, 0.2),
              title: 'Cycling',
              subtitle: 'Yesterday 6:15 PM',
              metric1Label: 'Distance',
              metric1Value: '13.2 km',
              metric2Label: 'Duration',
              metric2Value: '45 min',
              metric3Label: 'Calories',
              metric3Value: '320 kcal',
              isTrue: false,
            ),
            ActivityCard(
              image: "assets/images/dumbell.svg",
              iconColor: Color(0xFFFF1919),
              iconBackgroundColor: Color.fromRGBO(255, 25, 25, 0.2),
              title: 'Strength Training',
              subtitle: 'May  8:00 PM',
              metric1Label: 'Set',
              metric1Value: '5 Sets',
              metric2Label: 'Duration',
              metric2Value: '25 min',
              metric3Label: 'Calories',
              metric3Value: '156 kcal',
              isTrue: true,
            ),
            ActivityMetricsWidget(
              title: 'Other Activity Metrics',
              metrics: sampleMetrics,
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

