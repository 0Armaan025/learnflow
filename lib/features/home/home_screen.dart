import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  Future<void> sendPrompt(String prompt) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://localhost:80/textPrompt',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: jsonEncode(<String, String>{"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data);
        final botResponse = responseData['bot'];

        // Handle the response from the server (e.g., display it to the user)
        print("Bot Response: $botResponse");
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 260,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                            "Looks like it's the time to study again? 🤔",
                            style: GoogleFonts.poppins(
                                color: Pallete().headlineTextColor,
                                fontSize: 16)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Lottie.asset(
                        'assets/lottie/hello_animation.json',
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? '$_lastWords'
                    : _speechEnabled
                        ? 'Tap the microphone to start listening...'
                        : 'Speech not available',
              ),
              ElevatedButton(
                onPressed: () {
                  sendPrompt("heya");
                },
                child: Text("click me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
