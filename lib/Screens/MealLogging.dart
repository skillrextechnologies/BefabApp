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
import 'package:mobile_scanner/mobile_scanner.dart'; // >>> ADDED
import '../services/health_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealLogging extends StatefulWidget {
  @override
  _MealLoggingState createState() => _MealLoggingState();
}

class _MealLoggingState extends State<MealLogging> {
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

  final List<MealOption> sampleMeals = [
    MealOption(
      name: 'Breakfast',
      calories: 320,
      selectedBgColor: Color(0xFFFFF0F0),
    ),
    MealOption(name: 'Lunch', calories: 480),
    MealOption(name: 'Dinner', calories: 450),
    MealOption(name: 'Snack', calories: 0),
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
        surfaceTintColor: Colors.transparent, // Prevent M3 tint
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
            MetricsOverview(
              healthData: {
                'Calories': {
                  'data':
                      getHealthValue(
                        'HealthDataType.TOTAL_CALORIES_BURNED',
                      )['data'],
                  'unit': 'kcal',
                },
                'Water': {
                  'data': getHealthValue('HealthDataType.WATER')['data'],
                  'unit': getHealthValue('HealthDataType.WATER')['unit'],
                },
                'Sleep': {
                  'data':
                      getHealthValue('HealthDataType.SLEEP_SESSION')['data'],
                  'unit':
                      getHealthValue('HealthDataType.SLEEP_SESSION')['unit'],
                },
              },
            ),
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
                  child: Text(
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                  // >>> UPDATED: open scanner and return value
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BarcodeScannerScreen(),
                      ),
                    );
                    if (result != null) {
                      debugPrint("✅ Scanned Barcode: $result");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Scanned: $result")),
                      );
                      // If you later want to auto-add an item, do it here.
                      // setState(() { sampleItems.add(...); });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10), // ✅ FIXED
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBarcode(), // Ensure this has no padding/margin
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
            SizedBox(height: 24),
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

/// ======================================================================
/// Minimal Scanner Screen glued at the end of THIS FILE (no extra files).
/// ======================================================================
/// ======================================================================
/// Minimal Scanner Screen glued at the end of THIS FILE (no extra files).
/// ======================================================================

// --- helper: fetch product info by barcode ---
Future<Map<String, dynamic>?> fetchProductFromBarcode(String barcode) async {
  final url = Uri.parse("https://world.openfoodfacts.org/api/v0/product/$barcode.json");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['status'] == 1) {
      return data['product'];
    } else {
      return null; // not found
    }
  } else {
    throw Exception("API Error: ${response.statusCode}");
  }
}

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  bool _scanned = false; // ✅ guard to prevent multiple pops

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Barcode"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: MobileScanner(
        onDetect: (barcodeCapture) async {
          if (_scanned) return; // ✅ ignore if already scanned
          _scanned = true;

          final barcodes = barcodeCapture.barcodes;
          if (barcodes.isNotEmpty) {
            final code = barcodes.first.rawValue;
            if (code != null) {
              try {
                final product = await fetchProductFromBarcode(code);

                if (product != null && mounted) {
                  Navigator.pop(context, {
                    "barcode": code,
                    "name": product["product_name"] ?? "Unknown",
                    "brand": product["brands"] ?? "N/A",
                    "calories": product["nutriments"]?["energy-kcal_100g"],
                  });
                } else {
                  if (mounted) {
                    Navigator.pop(context, {
                      "barcode": code,
                      "error": "Product not found",
                    });
                  }
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context, {
                    "barcode": code,
                    "error": "API error: $e",
                  });
                }
              }
            }
          }
        },
      ),
    );
  }
}
