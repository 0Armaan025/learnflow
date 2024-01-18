import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';

class CustomSignUpButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomSignUpButton(
      {super.key, required this.onPressed, required this.text});

  @override
  State<CustomSignUpButton> createState() => _CustomSignUpButtonState();
}

class _CustomSignUpButtonState extends State<CustomSignUpButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Pallete().buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: GoogleFonts.poppins(
            color: Pallete().buttonTextColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
