import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
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



  String statusText = "";

  String questionTitle = "";
  String option1 = "";
  String option2 = "";
  String option3 = "";
  String option4 = "";
  String answer = "";

void getQuestionAndAnswer(String scannedText) async {
  Dio dioClient = Dio();
  const url = 'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
  final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};

  try {
    // Generate question
    final questionBody = {
      'prompt': {'text': 'What are the questions that can be made on the basis of (just say one question): $scannedText'},
    };
    final questionResponse = await dioClient.post(url, queryParameters: queryParameters, data: questionBody);
    final Map<String, dynamic> questionData = questionResponse.data;
    final List<dynamic> questionCandidates = questionData['candidates'];
    questionTitle = questionCandidates[0]['output'];

    // Generate options
  for (int i = 1; i <= 4; i++) {
  final optionBody = {
    'prompt': {'text': 'Just answer in one word, give options for this question ($i option), $questionTitle'},
  };
  final optionResponse = await dioClient.post(url, queryParameters: queryParameters, data: optionBody);
  final Map<String, dynamic> optionData = optionResponse.data;
  final List<dynamic> optionCandidates = optionData['candidates'];

  // Ensure we have at least i options
  if (optionCandidates.length >= i) {
    switch (i) {
      case 1:
        option1 = optionCandidates[0]['output'];
        break;
      case 2:
        option2 = optionCandidates[1]['output'];
        break;
      case 3:
        option3 = optionCandidates[2]['output'];
        break;
      case 4:
        option4 = optionCandidates[3]['output'];
        break;
    }
  }
}
    // Set correct answer
    answer = option3;
  } catch (e) {
    print('Error: $e');
    // Handle error accordingly
  }
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
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: ClipRect(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 176, 176, 176).withOpacity(0.5),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(),
        ),
      ),
    ),
  );
}
