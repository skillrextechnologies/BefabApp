import 'package:befab/charts/PieChart.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/DateSelector.dart';
import 'package:befab/components/MealBreakdown.dart';
import 'package:befab/components/MealTypeSelector.dart';
import 'package:befab/components/NutritionTracker.dart';
import 'package:befab/components/ProgressSummaryWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class AddMeal extends StatefulWidget {
  @override
  _AddMealState createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
DateTime selectedDate = DateTime.now();
  final List<MealOption> sampleMeals = [
    MealOption(
      name: 'Breakfast',
      calories: 320,
      textColor: Color(0xFF8B4513),
      subtextColor: Color(0xFF666666),
      bgColor: Color(0xFFF5F5F5),
      borderColor: Color(0xFFE0E0E0),
      selectedBgColor: Color(0xFFFFF0F0),
      selectedBorderColor: Color(0xFF8B4513),
    ),
    MealOption(
      name: 'Lunch',
      calories: 480,
      textColor: Color(0xFF8B4513),
      subtextColor: Color(0xFF666666),
      bgColor: Color(0xFFF5F5F5),
      borderColor: Color(0xFFE0E0E0),
      selectedBgColor: Color(0xFFFFF0F0),
      selectedBorderColor: Color(0xFF8B4513),
    ),
    MealOption(
      name: 'Dinner',
      calories: 450,
      textColor: Color(0xFF8B4513),
      subtextColor: Color(0xFF666666),
      bgColor: Color(0xFFF5F5F5),
      borderColor: Color(0xFFE0E0E0),
      selectedBgColor: Color(0xFFFFF0F0),
      selectedBorderColor: Color(0xFF8B4513),
    ),
    MealOption(
      name: 'Snack',
      calories: 0,
      textColor: Color(0xFF8B4513),
      subtextColor: Color(0xFF666666),
      bgColor: Color(0xFFF5F5F5),
      borderColor: Color(0xFFE0E0E0),
      selectedBgColor: Color(0xFFFFF0F0),
      selectedBorderColor: Color(0xFF8B4513),
    ),
  ];
  void _goToPrevious() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _goToNext() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  

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
      //   title: "Nutrition Detail",
      //   // rightWidget: Icon(Icons.more_vert, color: Colors.black),
      //   backgroundColor: Colors.white,
      // ),
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
          'Nutrition Detail',
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
            DateSelector(
              selectedDate: selectedDate,
              onPrevious: _goToPrevious,
              onNext: _goToNext,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Calories Summery",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ProgressSummaryWidget(
              title: 'Summary',
              consumed: 1250,
              goal: 2000,
              burned: 320,
              progressColor: Color(0xFF862633),
              unit: 'cal',
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Macro Breakdown",
                  style: GoogleFonts.lexend(
                    color: Color(0xFF121714),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            MacroBreakdownChart(
              title: 'Macro Breakdown',
              totalCalories: 1250,
              caloriesLabel: 'calories',
              proteinLabel: 'Protein',
              proteinAmount: '65g',
              proteinPercentage: '26%',
              proteinCalories: '260 cal',
              fatsLabel: 'Fats',
              fatsAmount: '48g',
              fatsPercentage: '35%',
              fatsCalories: '432 cal',
              carbsLabel: 'Carbs',
              carbsAmount: '132g',
              carbsPercentage: '39%',
              carbsCalories: '558 cal',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Nutrition tracker",
                  style: GoogleFonts.inter(
                    color: Color(0xFF121714),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            NutritionTracker(
              summaryLabel: 'Summary',
              nutritionItems: const [
                NutritionItem(
                  name: 'Fiber',
                  currentValue: '18',
                  targetValue: '25',
                  unit: 'g',
                ),
                NutritionItem(
                  name: 'Sugar',
                  currentValue: '24',
                  targetValue: '30',
                  unit: 'g',
                ),
                NutritionItem(
                  name: 'Sodium',
                  currentValue: '1450',
                  targetValue: '2300',
                  unit: 'mg',
                ),
                NutritionItem(
                  name: 'Fats',
                  currentValue: '12',
                  targetValue: '16',
                  unit: 'g',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Meal Breakdown",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MealBreakdown(
                heading: "Breakfast (320 cal)",
                meals: [
                  {'meal': 'Proteins', 'grams': '15g'},
                  {'meal': 'Fiber', 'grams': '12g'},
                  {'meal': 'Carbs', 'grams': '52g'},
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MealBreakdown(
                heading: "Lunch (480 cal)",
                meals: [
                  {'meal': 'Proteins', 'grams': '28g'},
                  {'meal': 'Fiber', 'grams': '18g'},
                  {'meal': 'Carbs', 'grams': '52g'},
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MealBreakdown(
                heading: "Dinner (450 cal)",
                meals: [
                  {'meal': 'Proteins', 'grams': '22g'},
                  {'meal': 'Fiber', 'grams': '18g'},
                  {'meal': 'Carbs', 'grams': '52g'},
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Recommendation",
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

