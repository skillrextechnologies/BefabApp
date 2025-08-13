import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';

class CompetitionsListPage extends StatelessWidget {
  final List<String> titles = ["Title", "Title", "Title","Title", "Title", "Title"];

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
          const SizedBox(width: 8),
          Icon(Icons.arrow_back, color: Colors.black),
        ],
      ),
    ),
    centerTitle: true,
    title: const Text(
      'Competitions',
      style: TextStyle(color: Colors.black,fontSize: 16),
    ),
  ),
  body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(height: 12),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ToggleOptions(), // Aligned to the left
    ),
    const SizedBox(height: 12),
    Expanded(
      child: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (_, index) {
          return Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
        children: [
          // Rounded Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 56,
              height: 56,
              color: Colors.grey.shade200,
              child: Image.asset(
                "assets/images/list.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Subtitle",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // JOIN Button centered
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "JOIN",
              style: TextStyle(
                color: Color(0xFF862633),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),

    // Divider aligned properly
    Padding(
      padding: const EdgeInsets.only(left: 84.0, right: 16.0),
      child: const Divider(
        height: 1,
        color: Colors.grey,
        thickness: 0.5,
      ),
    ),
  ],
);

        },
      ),
    ),
  ],
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


class ToggleOptions extends StatefulWidget {
  @override
  _ToggleOptionsState createState() => _ToggleOptionsState();
}

class _ToggleOptionsState extends State<ToggleOptions> {
  int selectedIndex = 1; // 0 for first, 1 for second

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildOption("My Progress", 0,"competitions-progress"),
        const SizedBox(width: 24),
        _buildOption("Active Competitions", 1,'competitions-list'),
      ],
    ),
  );
  }

  Widget _buildOption(String text, int index,String url) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (url.isNotEmpty) {
    Navigator.pushNamed(context, '/$url');
  }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 2,
            width: 120,
            color:  Color(0xFFE5E8EB),
          ),
        ],
      ),
    );
  }
}
