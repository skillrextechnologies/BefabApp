import 'package:befab/components/BarCodeScannerWidget.dart';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:befab/components/FavouritesGridWidget.dart';
import 'package:befab/components/HeadingWithImageRow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class SearchFood extends StatefulWidget {
  @override
  _SearchFoodState createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  @override
  Widget build(BuildContext context) {
    final List<FavouriteCategory> sampleCategories = [
      FavouriteCategory.withIcon(
        name: 'Fruits',
        icon: Icons.apple,
        iconColor: Color(0xFF862633),
      ),
      FavouriteCategory.withIcon(
        name: 'Vegetables',
        icon: Icons.eco,
        iconColor: Color(0xFF862633),
      ),
      FavouriteCategory.withIcon(
        name: 'Grains',
        icon: Icons.grass,
        iconColor: Color(0xFF862633),
      ),
      FavouriteCategory.withIcon(
        name: 'Dairy',
        icon: Icons.local_drink,
        iconColor: Color(0xFF862633),
      ),
      FavouriteCategory.withIcon(
        name: 'Proteins',
        icon: Icons.restaurant,
        iconColor: Color(0xFF862633),
      ),
      FavouriteCategory.withIcon(
        name: 'More',
        icon: Icons.more_horiz,
        iconColor: Color(0xFF862633),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,         // Solid white
  elevation: 0,                          // No shadow
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
          'Search Food',
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
            // Green theme static version
            // Compact version
            StaticBarcodeScannerWidget(
              height: 160,
              padding: EdgeInsets.all(8),
              borderRadius: 4,
              textStyle: TextStyle(fontSize: 12, color: Color(0xFF862633)),
              onTap: () {
                print('Compact scanner tapped!');
              },
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
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBarcode(), // Ensure this has no padding/margin
                        // No SizedBox or spacing here
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Recent Foods",
                    style: GoogleFonts.lexend(
                            color: Color(0xFF000000),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    "view all",
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
              heading: "Scrambled Eggs",
              subtitle: "2 Large eggs, 140 cal",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 32,
                  color: Color(0xFF862633),
                ),
                          onPressed: () {},

              ),
            ),
            HeadingWithImageRow(
              heading: "Whole white toast",
              subtitle: "1 slice, 80 cal",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 32,
                  color: Color(0xFF862633),
                ),
                          onPressed: () {},

              ),
            ),
            HeadingWithImageRow(
              heading: "Apple",
              subtitle: "1 Medium, 140 cal",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 32,
                  color: Color(0xFF862633),
                ),
                          onPressed: () {},

              ),
            ),
            HeadingWithImageRow(
              heading: "Coffee with milk",
              subtitle: "2 cups, 40 cal",
              trailingWidget: IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 32,
                  color: Color(0xFF862633),
                ),
                          onPressed: () {},

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My Favourits",
                    style: GoogleFonts.lexend(
                            color: Color(0xFF000000),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    "view all",
                    style: GoogleFonts.lexend(
                            color: Color(0xFF862633),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
            FavouritesGridWidget(
              categories: sampleCategories,
              onViewAllTap: () {
                print('View all tapped!');
              },
              onCategoryTap: (category) {
                print('Category tapped: ${category.name}');
              },
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
