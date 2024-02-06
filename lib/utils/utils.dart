import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnflow/common/constants/constants.dart';

void moveScreen(BuildContext context, Widget screenName,
    {bool isPushReplacement = false}) {
  if (isPushReplacement) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

void pickImage(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    File _tempFile = File(image.path);
    imageFile = _tempFile;
  } else {
    showSnackBar(context, "Please choose an image");
  }
}

AppBar buildAppBar(BuildContext context, {String title = "DARE"}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 26,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent, // Set transparent background
    elevation: 0,
    flexibleSpace: ClipRect(
      // Clips the blur to the appBar area
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 176, 176, 176)
              .withOpacity(0.5), // Adjust transparency
        ),
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust blur intensity
          child: Container(),
        ),
      ),
    ),
  );
}
