import 'package:befab/charts/BloodPressureWidget.dart';
import 'package:befab/components/ActivityStatCard.dart';
import 'package:befab/components/BodyMetricsWidget.dart';
import 'package:befab/components/CustomAppHeader.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/HealthMetricsListWidget.dart';
import 'package:befab/components/HeartRateWidget.dart';
import 'package:befab/services/health_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

import 'package:flutter/material.dart';

class VitalsMeasurement extends StatefulWidget {
  @override
  _VitalsMeasurementState createState() => _VitalsMeasurementState();
}

class _VitalsMeasurementState extends State<VitalsMeasurement> {

final HealthService healthService = HealthService();
  Map<String, dynamic>? healthData;

  @override
  void initState() {
    super.initState();

    // 👇 FIX: Only run after widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHealthData();
    });
  }

  Future<void> _loadHealthData() async {
    bool isInstalled = await healthService.isHealthAppInstalled();
    if (!isInstalled) {
      healthService.suggestInstallHealthApp(context);
      return;
    }

    bool authorized = await healthService.requestAuthorization();
    debugPrint("$authorized");
    if (!authorized) {
      debugPrint("❌ Health permissions denied!");
      return;
    }

    Map<String, dynamic> data = await healthService.fetchAllData(
      from: DateTime.now().subtract(const Duration(days: 30)),
      to: DateTime.now(),
    );

    if (!mounted) return;
    setState(() {
      healthData = data;
    });

    // sendData(data);

    debugPrint("✅ Platform: ${healthService.getPlatform()}");
    debugPrint(
      "✅ Fetched health data: ${getHealthValue('HealthDataType.STEPS')}",
    );
  }

  // Helper to get a single value safely from healthData
  /// Sums all entries in `healthData[type]` and returns "total unit"
  /// Works with entries shaped like:
  /// { "value": {"numericValue": 10}, "unit": "COUNT", ... }
  // --- Simplified units map ---
  Map<String, String> simplifiedUnits = {
    // Distance
    "METER": "m",
    "KILOMETER": "km",
    "MILE": "mi",
    "YARD": "yd",
    "FOOT": "ft",

    // Weight
    "GRAM": "g",
    "KILOGRAM": "kg",
    "OUNCE": "oz",
    "POUND": "lb",

    // Pressure
    "MILLIMETER_OF_MERCURY": "mmHg",
    "INCH_OF_MERCURY": "inHg",
    "PASCAL": "Pa",
    "KILOPASCAL": "kPa",

    // Temperature
    "CELSIUS": "°C",
    "FAHRENHEIT": "°F",
    "KELVIN": "K",

    // Energy
    "CALORIE": "kcal",
    "KILOJOULE": "kJ",

    // Time
    "SECOND": "s",
    "MINUTE": "min",
    "HOUR": "h",
    "DAY": "d",

    // Volume / Liquids
    "LITER": "L",
    "MILLILITER": "mL",
    "FLUID_OUNCE_US": "fl oz",

    // Counts / Steps
    "COUNT": "",
    "BEAT": "beat",
    "BEAT_PER_MINUTE": "bpm",
    "REP": "rep",

    // Percentages
    "PERCENTAGE": "%",

    // Sleep / activity types
    "SLEEP_ASLEEP": "sleep",
    "SLEEP_IN_BED": "in bed",
    "SLEEP_AWAKE": "awake",

    // Other HealthKit / Health Connect types
    "DISTANCE_WALKING_RUNNING": "m",
    "DISTANCE_CYCLING": "m",
    "ACTIVE_ENERGY_BURNED": "kcal",
    "BASAL_ENERGY_BURNED": "kcal",
    "BODY_MASS_INDEX": "BMI",
    "BODY_FAT_PERCENTAGE": "%",
    "LEAN_BODY_MASS": "kg",
    "RESTING_HEART_RATE": "bpm",
    "HEART_RATE": "bpm",
    "STEP_COUNT": "",
    "FLIGHTS_CLIMBED": "fl",
    "WALKING_HEART_RATE": "bpm",
    "VO2_MAX": "ml/kg/min",
    "DISTANCE_SWIMMING": "m",
    "SWIM_STROKE_COUNT": "stroke",
    "WORKOUT_DURATION": "min",
    "DURATION": "min",
    "BODY_TEMPERATURE": "°C",
    "BLOOD_PRESSURE_SYSTOLIC": "mmHg",
    "BLOOD_PRESSURE_DIASTOLIC": "mmHg",
    "BLOOD_GLUCOSE": "mg/dL",
    "BLOOD_OXYGEN": "%",
    "RESPIRATORY_RATE": "breaths/min",
    "OXYGEN_SATURATION": "%",
    "HEADACHE_SEVERITY": "",
    "MOOD": "",
    "STRESS_LEVEL": "",
    "WATER": "L",
    "CAFFEINE": "mg",
    "ALCOHOL_CONSUMED": "g",
    "TOBACCO_SMOKED": "cig",
    "BODY_MASS": "kg",
    "HEIGHT": "m",
    "BEATS_PER_MINUTE": "bpm",
    "PERCENT": "%",
  };

  // --- Your function remains unchanged except mapping unit at the end ---
  Map<String, dynamic> getHealthValue(
    String type, {
    int decimalsIfDouble = 2,
    bool convertMetersToKm = false,
  }) {
    if (healthData == null) return {"data": "--", "unit": ""};

    final raw = healthData![type];
    if (raw is! List || raw.isEmpty) return {"data": "--", "unit": ""};

    // --- pick the most common unit present in the list ---
    String _resolveUnit(List list) {
      final counts = <String, int>{};
      for (final e in list) {
        if (e is Map) {
          String? u;
          if (e['unit'] is String) {
            u = e['unit'] as String;
          }
          if (u != null && u.isNotEmpty) {
            counts[u] = (counts[u] ?? 0) + 1;
          }
        }
      }
      if (counts.isEmpty) return '';
      return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    }

    final unitFromData = _resolveUnit(raw);

    // --- sum numeric values ---
    num total = 0;

    for (final e in raw) {
      if (e is! Map) continue;

      final value = e['value'];
      if (value != null) {
        total += value.numericValue;
      }
    }

    // optional unit conversion
    String outUnit = simplifiedUnits[unitFromData] ?? unitFromData;
    if (convertMetersToKm && unitFromData == "METER") {
      total = total / 1000;
      outUnit = "km";
    }

    // format nicely
    String formatted;
    if (total % 1 == 0) {
      formatted = total.toInt().toString();
    } else {
      formatted = total.toStringAsFixed(decimalsIfDouble);
    }

    return {"data": formatted, "unit": outUnit};
  }


  
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
  final List<HealthMetric> sampleMetrics = [
      HealthMetric(
        image: "assets/images/heartbeat.svg",
        iconColor: const Color(0xFF862633),
        iconBackgroundColor: const Color.fromRGBO(134, 38, 51, 0.2),
        title: 'Heart Rate',
        timestamp: 'Today 10:23 Am',
        value: (getHealthValue('HealthDataType.HEART_RATE')['data']),
                      unit: getHealthValue('HealthDataType.HEART_RATE')['unit'],
        onTap: () => print('Heart Rate tapped'),
      ),
      HealthMetric(
        image: "assets/images/ic5.svg",
        iconColor: const Color(0xFF0074C4),
        iconBackgroundColor: const Color.fromRGBO(0, 116, 196, 0.2),
        title: 'Blood Pressure',
        timestamp: 'Today 10:23 Am',
        value: (getHealthValue('HealthDataType.BLOOD_PRESSURE_SYSTOLIC')['data']),
                      unit: getHealthValue('HealthDataType.BLOOD_PRESSURE_SYSTOLIC')['unit'],
        onTap: () => print('Blood Pressure tapped'),
      ),
      HealthMetric(
        image: "assets/images/ic6.svg",
        iconColor: const Color(0xFF1A9B8E),
        iconBackgroundColor: const Color.fromRGBO(26, 155, 142, 0.2),
        title: 'Blood Glucose',
        timestamp: 'Today 10:23 Am',
        value: (getHealthValue('HealthDataType.BLOOD_GLUCOSE')['data']),
                      unit: getHealthValue('HealthDataType.BLOOD_GLUCOSE')['unit'],
        onTap: () => print('Blood Glucose tapped'),
      ),
      HealthMetric(
        image: "assets/images/ic7.png",
        iconColor: const Color(0xFF2563EB),
        iconBackgroundColor: const Color.fromRGBO(37, 99, 235, 0.2),
        title: 'Oxygen (Spo2)',
        timestamp: 'Today 10:23 Am',
        value: (getHealthValue('HealthDataType.BLOOD_OXYGEN')['data']),
                      unit: getHealthValue('HealthDataType.BLOOD_OXYGEN')['unit'],
        onTap: () => print('Oxygen tapped'),
        isTrue:true
      ),
    ];
     
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
                      value: getHealthValue('HealthDataType.BLOOD_GLUCOSE')['data'],
                      unit: getHealthValue('HealthDataType.BLOOD_GLUCOSE')['unit'],
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
                      value: getHealthValue('HealthDataType.BLOOD_OXYGEN')['data'],
                      unit: getHealthValue('HealthDataType.BLOOD_OXYGEN')['unit'],
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
                      value: getHealthValue('HealthDataType.RESPIRATORY_RATE')['data'],
                      unit: getHealthValue('HealthDataType.RESPIRATORY_RATE')['unit'],
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
                      value: getHealthValue('HealthDataType.BODY_TEMPERATURE')['data'],
                      unit: getHealthValue('HealthDataType.BODY_TEMPERATURE')['unit'],
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
                      value: getHealthValue('HealthDataType.WEIGHT')['data'],
                      unit: getHealthValue('HealthDataType.WEIGHT')['unit'],
                      changeText: '+ 0.5 from last week',
                      changeColor: const Color(0xFF4CAF50),
                    ),
                    BodyMetric(
                      label: 'Height',
                      value: getHealthValue('HealthDataType.HEIGHT')['data'],
                      unit: getHealthValue('HealthDataType.HEIGHT')['unit'],
                      additionalInfo: 'Last Update 3 mon ago',
                      additionalInfoColor: Colors.grey[600],
                    ),
                  ],
                  secondaryMetrics: [
                    BodyMetric(
                      label: 'BMI',
                      value: getHealthValue('HealthDataType.BODY_MASS_INDEX')['data'],
                      status: 'Normal',
                      statusColor: const Color(0xFF4CAF50),
                    ),
                    BodyMetric(
                      label: 'Calories',
                      value: getHealthValue('HealthDataType.TOTAL_CALORIES_BURNED')['data'],
                      unit: "",
                      status: 'Normal',
                      statusColor: const Color(0xFF4CAF50),
                    ),
                    BodyMetric(
                      label: 'Body Fat',
                      value: getHealthValue('HealthDataType.BODY_FAT_PERCENTAGE')['data'],
                      unit: getHealthValue('HealthDataType.BODY_FAT_PERCENTAGE')['unit'],
                      additionalInfo: '76.1%',
                      additionalInfoColor: Colors.grey[600],
                    ),
                  ],
                  tertiaryMetrics: [
                    BodyMetric(
                      label: 'Bone Mass',
                      value: ((double.tryParse(getHealthValue('HealthDataType.WEIGHT')['data'].toString()) ?? 0.0) * 0.12).toStringAsFixed(1),
                      unit: getHealthValue('HealthDataType.WEIGHT')['unit'],
                    ),
                    BodyMetric(
                      label: 'Water',
                      value: (getHealthValue('HealthDataType.WATER')['data']),
                      unit: getHealthValue('HealthDataType.WATER')['unit'],
                    ),
                    BodyMetric(
                      label: 'Heart Rate',
                      value: (getHealthValue('HealthDataType.HEART_RATE')['data']),
                      unit: getHealthValue('HealthDataType.HEART_RATE')['unit'],
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


