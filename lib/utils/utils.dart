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


  String questionTitle = "";
  String statusText = "";

//   Future<String?> getQuestionTitle(String scannedText) async {
//   Dio dioClient = Dio();
//   const url = 'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
//   final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};

//   try {
//     // Generate question
//     final questionBody = {
//       'prompt': {'text': 'What are the questions that can be made on the basis of (just say one question): $scannedText'},
//     };
//     final questionResponse = await dioClient.post(url, queryParameters: queryParameters, data: questionBody);

//     final Map<String, dynamic>? questionData = questionResponse.data;
//     final List<dynamic>? questionCandidates = questionData?['candidates'];

//     if (questionCandidates != null && questionCandidates.isNotEmpty) {
//       questionTitle = questionCandidates[0]['output'];
//       return questionCandidates[0]['output'];
//     } else {
//       print('Error: No candidates found in the question response.');
//       return null;
//     }
//   } catch (e) {
//     print('Error: $e');
//     // Handle error accordingly
//     return null;
//   }
// }

int score = 0;

 String? option1;
 String? option2;
 String? option3;
 String? option4;

 String? answer;

// Future<void> getOptions(String questionTitle) async {
//   Dio dioClient = Dio();
//   const url = 'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
//   final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};

//   // Helper function to get option
//   Future<String?> getOption(String prompt) async {
//     try {
//       final optionBody = {'prompt': {'text': prompt}};
//       final optionResponse = await dioClient.post(url, queryParameters: queryParameters, data: optionBody);
//       print('Option Response: $optionResponse'); // Add this line for debugging
//       final Map<String, dynamic>? optionData = optionResponse.data;
      
//       if (optionData != null) {
//         final List<dynamic>? optionCandidates = optionData['candidates'];

//         if (optionCandidates != null && optionCandidates.isNotEmpty) {
//           return optionCandidates[0]['output'];
//         } else {
//           print('Error: No candidates found in the response for prompt: $prompt');
//         }
//       } else {
//         print('Error: Unexpected response structure for prompt: $prompt');
//       }

//       return null;
//     } catch (e) {
//       print('Error fetching option: $e');
//       return null;
//     }
//   }

//   // Generate options
//   option1 = await getOption('Just answer in one word, give options for this question (1st option), $questionTitle') ?? "";
//   option2 = await getOption('Just answer in one word, give options for this question (2nd option), $questionTitle. Avoid repeating the previous options: ${option1 ?? ""}') ?? "";
//   option3 = await getOption('Just answer in one word, give options for this question (3rd and correct option), $questionTitle. Avoid repeating the previous options: ${option1 ?? ""}, ${option2 ?? ""}') ?? "";
//   option4 = await getOption('Just answer in one word, give options for this question (4th option), $questionTitle. Avoid repeating the previous options: ${option1 ?? ""}, ${option2 ?? ""}, ${option3 ?? ""}') ?? "";

//   // Set correct answer
//   answer = option3;

//   print('Option 1: $option1');
//   print('Option 2: $option2');
//   print('Option 3: $option3');
//   print('Option 4: $option4');
//   print('Correct Answer: $answer');
// }



// Future<void> getQuestionAndAnswer(String scannedText) async {
//   String? questionTitle = await getQuestionTitle(scannedText);
//   if (questionTitle != null) {
//     await getOptions(questionTitle);
//   }
// }




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
