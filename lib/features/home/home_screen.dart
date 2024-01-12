import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:simplytranslate/simplytranslate.dart';
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
  final gt = SimplyTranslator(EngineType.google);
  FlutterTts flutterTts = FlutterTts();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void sendPrompt(String text) async {
    Dio dioClient = Dio();

    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

    String textResult = await gt.trSimply(text, "hi", 'en');

    final queryParameters = {'key': "<MY API KEY>"};
    final body = {
      'prompt': {'text': '$textResult'}
    };

    final response =
        await dioClient.post(url, queryParameters: queryParameters, data: body);

    Map<String, dynamic> responseData = response.data;

    List<dynamic> candidates = responseData['candidates'];

    String output = candidates[0]['output'];

    textResult = await gt.trSimply(output, "en", "hi");

    await flutterTts.speak(textResult.toString());

    print("The output is $output");
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
                  sendPrompt(_lastWords);
                },
                child: Text("click me"),
              ),
              ElevatedButton(
                onPressed: () {
                  flutterTts.stop();
                },
                child: Text("stop speaking"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
