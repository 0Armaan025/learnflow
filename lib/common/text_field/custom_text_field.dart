import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/pallete.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isObscure;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.isObscure = false,
      required this.hintText});

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 17),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: GoogleFonts.poppins(
                color: Pallete().headlineTextColor,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              obscureText: widget.isObscure,
              controller: widget.controller,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.quicksand(
                  color: Pallete().paragraphTextColor,
                  fontSize: 18,
                ),
                hintText: widget.hintText,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
