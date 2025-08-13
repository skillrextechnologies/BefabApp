import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String groupImage;
  final String groupName;
  final String groupType;
  final String postedTime;
  final String membersCount;
  final String description;
  final List<String> imageUrls;
  final VoidCallback onJoinPressed;

  const GroupCard({
    super.key,
    required this.groupImage,
    required this.groupName,
    required this.groupType,
    required this.postedTime,
    required this.membersCount,
    required this.description,
    required this.imageUrls,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top Info Section
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(groupImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(groupName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                      '$groupType · $postedTime\n$membersCount Members',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              TextButton(
                
  onPressed: () {
    Navigator.pushNamed(context, '/fitness-group');
  },
  style: TextButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 24),
    backgroundColor: Colors.grey.shade200, // Light grey background
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  child: const Text(
    "JOIN",
    style: TextStyle(color: Color(0xFF7121217),fontSize: 12),
  ),
),
            ],
          ),
        ),

        /// Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(description, style: const TextStyle(fontSize: 14)),
        ),

        const SizedBox(height: 12),

        /// Images Layout
        if (imageUrls.length >= 4) ...[
          // Row 1: Image 1 (50%) + Image 2 (25%) + Image 3 (25%)
          Row(
            children: [
              Image.asset(
                imageUrls[0],
                width: screenWidth * 0.5,
                height: 120,
                fit: BoxFit.cover,
              ),
                        const SizedBox(width: 4),

              Image.asset(
                imageUrls[1],
                width: screenWidth * 0.23,
                height: 120,
                fit: BoxFit.cover,
              ),
          const SizedBox(width: 4),

              Image.asset(
                imageUrls[2],
                width: screenWidth * 0.24,
                height: 120,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Row 2: Image 4 (50%) + empty space (50%)
          Row(
            children: [
              Image.asset(
                imageUrls[3],
                width: screenWidth * 0.5,
                height: 120,
                fit: BoxFit.cover,
              ),
              Container(
                width: screenWidth * 0.5,
                height: 120,
                color: Colors.transparent,
              ),
            ],
          )
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}
