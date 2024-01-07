import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/pallete.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText});

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Name",
          style: GoogleFonts.poppins(color: Pallete().headlineTextColor),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
