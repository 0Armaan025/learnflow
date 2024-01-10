import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/button/custom_continue_button.dart';
import 'package:learnflow/common/constants/constants.dart';
import 'package:learnflow/features/authentication/notifiers/auth_notifier.dart'
    as providerContext;
import 'package:learnflow/features/authentication/screens/signup/signup_screen.dart';
import 'package:learnflow/features/home/home_screen.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final authState = ref.watch(providerContext.authNotifierProvider);

    return Scaffold(
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  moveScreen(
                      context,
                      firebaseAuth.currentUser != null
                          ? HomeScreen()
                          : SignUpScreen(),
                      isPushReplacement: true);
                },
                child: Container(
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
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Interactive learning",
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
                    "Features like summarises, quizes and flash cards generation help students learn in a better way!",
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
                  child: Lottie.asset('assets/lottie/onboarding_2.json'),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              CustomContinueButton(
                onPressed: () {
                  moveScreen(
                      context,
                      firebaseAuth.currentUser != null
                          ? HomeScreen()
                          : SignUpScreen(),
                      isPushReplacement: true);
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
