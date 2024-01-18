import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/features/create_flash_cards/create_flash_cards.dart';
import 'package:learnflow/features/create_notes/create_notes_screen.dart';
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
  bool _isTtsSpeaking = false;

  void sendPrompt(String text) async {
    Dio dioClient = Dio();

    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

    String textResult = await gt.trSimply(text, "hi", 'en');

    final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};
    final body = {
      'prompt': {
        'text':
            '(respond like a friend, gen z, if it is a math question, do not use symbols instead say lke multipled by or depends), text is $textResult'
      }
    };

    final response =
        await dioClient.post(url, queryParameters: queryParameters, data: body);

    Map<String, dynamic> responseData = response.data;

    List<dynamic> candidates = responseData['candidates'];

    String output = candidates[0]['output'];
    output = output.replaceAll('`', '');

    output = output.replaceAll('*', '');
    output = output.replaceAll('#', '');

    textResult = await gt.trSimply(output, "en", "hi");
    _isTtsSpeaking = true;
    await flutterTts.speak(textResult.toString());
    _isTtsSpeaking = false;

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
    final size = MediaQuery.of(context).size;

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
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 250,
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
                    Positioned(
                      top: 280,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Center(
                          child: Text(
                            // If listening is active show the recognized words
                            _speechToText.isListening
                                ? '$_lastWords'
                                : _speechEnabled
                                    ? 'Tap the microphone for it to start listening...'
                                    : 'Speech not available',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 310,
                      left: 18,
                      child: Text(
                        "Help section! :D",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 26),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.3,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * 0.1,
                              width: size.width * 0.36,
                              decoration: BoxDecoration(
                                color: Colors.teal[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Reverse\nTeaching",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                moveScreen(context, CreateFlashCardsScreen(),
                                    isPushReplacement: true);
                              },
                              child: Container(
                                height: size.height * 0.1,
                                width: size.width * 0.36,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 45, 152, 142),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Create\nFlash Cards",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: size.height * 0.1,
                              width: size.width * 0.36,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 45, 152, 142),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Generate\nQuizzes",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                moveScreen(context, CreateNotesScreen(),
                                    isPushReplacement: true);
                              },
                              child: Container(
                                height: size.height * 0.1,
                                width: size.width * 0.36,
                                decoration: BoxDecoration(
                                  color: Colors.teal[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Create\nNotes",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    sendPrompt(_lastWords);
                  },
                  child: const Text('ASK AI')),
              ElevatedButton(
                  onPressed: () {
                    flutterTts.stop();
                  },
                  child: Text("Stop Listening")),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
