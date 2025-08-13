import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is included

class CalendarPage extends StatelessWidget {
  final List<Map<String, String>> tasks = [
    {"title": "Dev Team Meeting", "time": "10:00 - 11:00", "color": "red"},
    {"title": "SEO Workshop", "time": "11:00 - 12:00", "color": "blue"},
    {"title": "Design Meeting", "time": "01:00 - 02:00", "color": "orange"},
    {"title": "Lunch Break", "time": "12:00 - 01:00", "color": "grey"},
  ];

  Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Color(0xFF862633);
      case 'blue':
        return Color(0xFF0074C4);
      case 'orange':
        return Color(0xFFE73C1A);
      case 'grey':
        return Color(0xFFF8F5F5);
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,  // Prevent M3 tint

        elevation: 0,
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
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text('Calendar', style: TextStyle(color: Colors.black, fontSize: 16)),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/settings2.svg',
              width: 18,
              height: 18,
              color: const Color(0xFF862633),
            ),
            onPressed: () {
              // Handle settings tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Theme(
  data: Theme.of(context).copyWith(
    colorScheme: ColorScheme.light(
      primary: Color(0xFF862633), // <-- Selected date circle & header color
      onPrimary: Colors.white, // <-- Text color on selected date
      onSurface: Colors.black, // <-- Default text color
    ),
  ),
  child: CalendarDatePicker(
    initialDate: DateTime.now(),
    firstDate: DateTime(2022),
    lastDate: DateTime(2026),
    onDateChanged: (value) {
      // Handle selected date
    },
  ),
),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Daily Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),

            ...List.generate(tasks.length, (index) {
              if (index == 1) {
                final nextTask = index + 1 < tasks.length ? tasks[index + 1] : null;
                return Row(
                  children: [
                    Expanded(child: buildTaskContainer(tasks[index], getColorFromString)),
                    const SizedBox(width: 8),
                    if (nextTask != null)
                      Expanded(child: buildTaskContainer(nextTask, getColorFromString)),
                  ],
                );
              }

              if (index == 2) return const SizedBox.shrink();

              return buildTaskContainer(tasks[index], getColorFromString);
            }),
            const SizedBox(height: 24),
            
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
          onPressed: (){},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}

Widget buildTaskContainer(Map<String, String> task, Color Function(String) getColorFromString) {
  final bgColor = getColorFromString(task['color']!);
  final isGrey = task['color'] == 'grey';
  final textColor = isGrey ? Colors.black : Colors.white;

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          task['title']!,
          style: TextStyle(color: textColor,
          fontSize: 14),
        ),
        subtitle: Text(
          task['time']!,
          style: TextStyle(color: textColor,fontSize: 12),
        ),
      ),
    ),
  );
}

BottomNavigationBar buildBottomNavBar(int selectedIndex, Function(int) onTap) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    selectedItemColor: const Color(0xFF862633),
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Health'),
      BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''), // Spacer for FAB
      BottomNavigationBarItem(icon: Icon(Icons.video_collection), label: 'Video'),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
    ],
  );
}
