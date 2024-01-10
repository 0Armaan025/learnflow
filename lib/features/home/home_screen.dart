import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Lottie.asset(
                  'assets/lottie/hello_animation_1.json',
                ),
              ),
              Text("Looks like it's the time to study again? 🤔",
                  style:
                      GoogleFonts.poppins(color: Pallete().headlineTextColor)),
            ],
          ),
        ),
      ),
    );
  }
}
