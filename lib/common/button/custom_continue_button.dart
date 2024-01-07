import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContinueButton extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPressed;
  final String text;
  const CustomContinueButton({
    Key? key,
    this.bgColor = const Color(0xFF0e172c),
    this.textColor = const Color(0xFFfffffe),
    required this.onPressed,
    this.text = "Continue",
  }) : super(key: key);

  @override
  State<CustomContinueButton> createState() => CustomContinueButtonState();
}

class CustomContinueButtonState extends State<CustomContinueButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: size.height * 0.06,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.roboto(
            color: widget.textColor,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
