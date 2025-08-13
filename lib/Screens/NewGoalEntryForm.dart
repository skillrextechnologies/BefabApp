import 'package:befab/Screens/GoalSetSuccessPage.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/InputBox.dart';
import 'package:befab/components/ProgressSwitchRow.dart';
import 'package:befab/components/StepsChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class NewGoalPage extends StatefulWidget {
  const NewGoalPage({Key? key}) : super(key: key);

  @override
  State<NewGoalPage> createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {
  final TextEditingController goalController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();
  final TextEditingController milestoneController = TextEditingController();

  @override
  void dispose() {
    goalController.dispose();
    monthsController.dispose();
    milestoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(width: 16),
        SvgPicture.asset(
            'assets/images/cross.svg',
            width: 15,
            height: 15,
          ),            
          ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          'New Goal',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: EditableGoalInputBox(
            title: "What's your goal",
            hintText: "Drink more water, sleep better, get fit",
            controller: goalController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: EditableGoalInputBox(
            title: "By when",
            hintText: "5 months",
            controller: monthsController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: EditableGoalInputBox(
            title: "Milestones",
            hintText: "1,000 steps",
            controller: milestoneController,
          ),
        ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Get Personalized Tips",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ProgressSwitchRow(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Steps in 20 days"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "10k",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              ),
            ),
            
            StepsChart(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF862633),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed:
                  () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GoalSuccessPage();
                    },
                  ),

              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text('Set Goal', style: TextStyle(color: Colors.white)),
              ),
            ),
                        SizedBox(height: 20),

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

