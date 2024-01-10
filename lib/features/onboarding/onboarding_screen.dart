import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/button/custom_continue_button.dart';
import 'package:learnflow/features/onboarding/onboarding_screen_2.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(right: 12),
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Container(
                  width: size.width * 0.22,
                  height: size.height * 0.04,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Pallete().headlineTextColor,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Skip",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Reverse Teaching",
                  style: GoogleFonts.poppins(
                    color: Pallete().headlineTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: Text(
                    "Reverse teaching helps students to teach AI the concepts and then the AI will validate if it was wrong or right!",
                    style: GoogleFonts.headlandOne(
                      color: Pallete().paragraphTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Lottie.asset('assets/lottie/onboarding_1.json'),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              CustomContinueButton(
                onPressed: () {
                  moveScreen(context, OnBoardingScreen2());
                },
                text: "Continue ->",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
