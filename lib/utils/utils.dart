import 'dart:io';

import 'package:flutter/material.dart';
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
