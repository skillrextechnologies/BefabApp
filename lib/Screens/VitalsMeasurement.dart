import 'package:befab/charts/BloodPressureWidget.dart';
import 'package:befab/components/ActivityStatCard.dart';
import 'package:befab/components/BodyMetricsWidget.dart';
import 'package:befab/components/CustomAppHeader.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/HealthMetricsListWidget.dart';
import 'package:befab/components/HeartRateWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

import 'package:flutter/material.dart';

class VitalsMeasurement extends StatefulWidget {
  @override
  _VitalsMeasurementState createState() => _VitalsMeasurementState();
}

class _VitalsMeasurementState extends State<VitalsMeasurement> {
  final List<HealthMetric> sampleMetrics = [
      HealthMetric(
        image: "assets/images/heartbeat.svg",
        iconColor: const Color(0xFF862633),
        iconBackgroundColor: const Color.fromRGBO(134, 38, 51, 0.2),
        title: 'Heart Rate',
        timestamp: 'Today 10:23 Am',
        value: '72',
        unit: 'bpm',
        onTap: () => print('Heart Rate tapped'),
      ),
      HealthMetric(
        image: "assets/images/ic5.svg",
        iconColor: const Color(0xFF0074C4),
        iconBackgroundColor: const Color.fromRGBO(0, 116, 196, 0.2),
        title: 'Blood Pressure',
        timestamp: 'Today 10:23 Am',
        value: '118/76',
        onTap: () => print('Blood Pressure tapped'),
      ),
      HealthMetric(
        image: "assets/images/ic6.svg",
        iconColor: const Color(0xFF1A9B8E),
        iconBackgroundColor: const Color.fromRGBO(26, 155, 142, 0.2),
        title: 'Blood Glucose',
        timestamp: 'Today 10:23 Am',
        value: '98',
        unit: 'mg/dL',
        onTap: () => print('Blood Glucose tapped'),
      ),
      HealthMetric(
        image: "assets/images/ic7.png",
        iconColor: const Color(0xFF2563EB),
        iconBackgroundColor: const Color.fromRGBO(37, 99, 235, 0.2),
        title: 'Oxygen (Spo2)',
        timestamp: 'Today 10:23 Am',
        value: '95',
        unit: '%',
        onTap: () => print('Oxygen tapped'),
        isTrue:true
      ),
    ];
  final List<BloodPressureData> sampleData = [
      BloodPressureData(day: 'Mon', systolic: 120, diastolic: 78),
      BloodPressureData(day: 'Tue', systolic: 118, diastolic: 76),
      BloodPressureData(day: 'Wed', systolic: 115, diastolic: 75),
      BloodPressureData(day: 'Thu', systolic: 119, diastolic: 77),
      BloodPressureData(day: 'Fri', systolic: 122, diastolic: 79),
      BloodPressureData(day: 'Sat', systolic: 117, diastolic: 74),
      BloodPressureData(day: 'Sun', systolic: 118, diastolic: 75),
    ];
final List<HeartRateData> sampleData2 = [
      HeartRateData(time: '6AM', value: 68),
      HeartRateData(time: '9AM', value: 75),
      HeartRateData(time: '12PM', value: 82),
      HeartRateData(time: '3PM', value: 78),
      HeartRateData(time: '6PM', value: 85),
      HeartRateData(time: '9PM', value: 72),
      HeartRateData(time: '10PM', value: 70),
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
        title: "Vitals & Measurements",
        // rightWidget: Icon(Icons.more_vert, color: Colors.black),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Current Vitals",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:  Text(
                    "History",
                    style: GoogleFonts.inter(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HeartRateWidget(
                  title: 'Heart Rate',
                  currentHeartRate: 72,
                  unit: 'bpm',
                  status: 'Normal',
                  heartRateData: sampleData2,
                  minHeartRate: 58,
                  avgHeartRate: 72,
                  maxHeartRate: 110,
                  restingHeartRate: 62,
                  heartRateVariability: 58,
                ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BloodPressureWidget(
                  title: 'Blood Pressure',
                  systolicValue: 118,
                  diastolicValue: 75,
                  unit: 'mmHg',
                  status: 'Normal',
                  weeklyData: sampleData,
                  lastWeekAverage: '12/78',
                  lastReading: '2h ago',
                  mapValue: 89,
                  pulseValue: 49,
                ),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Other Vital Metrics",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                      image: "assets/images/ic6.svg",
                      imageColor: Color(0xFF1A9B8E),
                      imageBackgroundColor: Color.fromRGBO(26, 155, 142, 0.2),
                      title: "Blood Glucose",
                      value: "90",
                      unit: "mm/dL",
                      goalLabel: "Last reading: 4h ago",
                      progress: 5.2 / 8.0,
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/ic7.png",
                      imageColor: Color(0xFF2563EB),
                      imageBackgroundColor: Color.fromRGBO(37, 99, 235, 0.2),
                      title: "Oxygen(Sp02)",
                      value: "12%",
                      unit: "",
                      goalLabel: "Last reading: 2h ago",
                      progress: 12 / 15,
                      isTrue: true
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/lungs.svg",
                      imageColor: Color(0xFFFF1919),
                      imageBackgroundColor: Color.fromRGBO(255, 25, 25, 0.2),
                      title: "Respiratory Rate",
                      value: "16",
                      unit: "rpm",
                      goalLabel: "Last reading: 7h ago",
                      progress: 5.2 / 8.0,
                    ),
                  ),
                  ActivityStatCard(
                    stat: ActivityStat(
                      image: "assets/images/temp.svg",
                      imageColor: Color(0xFF9333EA),
                      imageBackgroundColor: Color.fromRGBO(147, 51, 234, 0.2),
                      title: "Temperature",
                      value: "36.7",
                      unit: "C",
                      goalLabel: "Last reading: 6h ago",
                      progress: 12 / 15,
                    ),
                  ),
          
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Body Measurement",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:  Text(
                    "Updates",
                    style: GoogleFonts.inter(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BodyMetricsWidget(
                  primaryMetrics: [
                    BodyMetric(
                      label: 'Weight',
                      value: '68.5',
                      unit: 'kg',
                      changeText: '+ 0.5 from last week',
                      changeColor: const Color(0xFF4CAF50),
                    ),
                    BodyMetric(
                      label: 'Height',
                      value: '175',
                      unit: 'cm',
                      additionalInfo: 'Last Update 3 mon ago',
                      additionalInfoColor: Colors.grey[600],
                    ),
                  ],
                  secondaryMetrics: [
                    BodyMetric(
                      label: 'BMI',
                      value: '22.4',
                      status: 'Normal',
                      statusColor: const Color(0xFF4CAF50),
                    ),
                    BodyMetric(
                      label: 'Weight',
                      value: '23',
                      unit: '%',
                      status: 'Normal',
                      statusColor: const Color(0xFF4CAF50),
                    ),
                    BodyMetric(
                      label: 'Weight',
                      value: '23',
                      unit: '%',
                      additionalInfo: '76.1%',
                      additionalInfoColor: Colors.grey[600],
                    ),
                  ],
                  tertiaryMetrics: [
                    BodyMetric(
                      label: 'Bone Mass',
                      value: '34',
                      unit: 'kg',
                    ),
                    BodyMetric(
                      label: 'Water',
                      value: '56',
                      unit: '%',
                    ),
                    BodyMetric(
                      label: 'Visceral Fat',
                      value: '6',
                    ),
                  ],
                ),
            ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Recent Reading",
                    style: GoogleFonts.inter(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HealthMetricsListWidget(
                metrics: sampleMetrics,
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


