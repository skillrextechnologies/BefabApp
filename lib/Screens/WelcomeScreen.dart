// welcome_screen.dart
import 'package:befab/Screens/SignInScreen.dart';
import 'package:befab/Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this import is at the top

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 36),
SvgPicture.asset('assets/images/logo.svg'),
            Center(
  child: Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Welcome to\n',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: 'BeFAB HBCU ',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF862633),
          ),
        ),
        TextSpan(
          text: 'Fitness',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  ),
),


            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
  child: Text(
    'Get access to our weight loss and diabetes management app tailored for the HBCU community.',
    textAlign: TextAlign.center,
    style: GoogleFonts.inter(
      color: Color(0xFF4E4E4E),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
),

            const SizedBox(height: 24),
Center(
  child: Image.asset(
    'assets/images/welcome_illustration.png',
    height: 250,
    width: MediaQuery.of(context).size.width * 0.9,
    fit: BoxFit.contain,
  ),
),

            const SizedBox(height: 24),
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
                  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpScreen()), // replace with your actual page
  ),
                  child:  Padding(
  padding:  EdgeInsets.symmetric(horizontal: 32, vertical: 12),
  child: Text(
    'Get Started',
    style: GoogleFonts.lexend(
      color: Colors.white,
      fontWeight: FontWeight.w600, // Optional: make it a bit bolder
      fontSize: 16,                // Optional: specify a font size
    ),
  ),
),

                ),
              ),
            ),
            TextButton(
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignInScreen()), // replace with your actual page
  );
},              child:  Text.rich(
                TextSpan(
  children: [
    TextSpan(
      text: 'Already have an account? ',
      style: GoogleFonts.lexend(
        color: Color(0xFF638773),
        fontSize: 14, // optional, adjust as needed
        fontWeight: FontWeight.w400,
      ),
    ),
    TextSpan(
      text: 'Sign In',
      style: GoogleFonts.lexend(
        color: Color(0xFF862633),
        fontSize: 14, // optional
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
