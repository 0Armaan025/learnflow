import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class ProgressCreatorScreen extends StatefulWidget {
  const ProgressCreatorScreen({super.key});

  @override
  State<ProgressCreatorScreen> createState() => _ProgressCreatorScreenState();
}

class _ProgressCreatorScreenState extends State<ProgressCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Center(
                child: Text("Let's make your progress", style: GoogleFonts.poppins()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}