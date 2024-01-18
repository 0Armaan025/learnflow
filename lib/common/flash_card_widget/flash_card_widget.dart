import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';

class FlashCardWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const FlashCardWidget({super.key, required this.text, required this.onTap});

  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.75,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Pallete().bgColor,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0).copyWith(top: 20),
            child: Text(
              "Your Flash card!",
              style: GoogleFonts.poppins(
                color: Pallete().headlineTextColor,
                fontSize: 34,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              height: size.height * 0.43,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Center(
                  child: Text(
                    widget.text,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Pallete().headlineTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: InkWell(
              onTap: () {
                widget.onTap();
              },
              child: Container(
                height: size.height * 0.08,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Pallete().buttonColor,
                ),
                child: Text(
                  "Next ->",
                  style: GoogleFonts.roboto(
                    color: Pallete().buttonTextColor,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
