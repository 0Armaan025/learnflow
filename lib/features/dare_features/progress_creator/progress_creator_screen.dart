import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/text_field/custom_text_field.dart';

class ProgressCreatorScreen extends StatefulWidget {
  const ProgressCreatorScreen({Key? key}) : super(key: key);

  @override
  State<ProgressCreatorScreen> createState() => _ProgressCreatorScreenState();
}

class _ProgressCreatorScreenState extends State<ProgressCreatorScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  String _selectedDifficulty = 'Medium';
  int selectedBtn = 0;
  List<bool> stepCompletion = [false, false, false]; // Tracks step completion
  List<String> generatedSteps = []; // Tracks generated steps

  @override
  void dispose() {
    super.dispose();
    _subjectController.dispose();
    _classController.dispose();
  }

  Future<void> generateTrack(
      String subject, String difficulty, bool isBookish) async {
    try {
      final source = isBookish ? 'Bookish' : 'Internet';
      final prompt =
          'Please help me generate educational content for $subject subject, $difficulty difficulty, and $source source';

      Dio dioClient = Dio();
      const url =
          'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
      final queryParameters = {
        'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"
      };

      final questionBody = {
        'prompt': {
          'text': prompt,
        },
      };

      final questionResponse = await dioClient.post(
        url,
        queryParameters: queryParameters,
        data: questionBody,
      );

      final Map<String, dynamic> questionData = questionResponse.data;
      final List<dynamic> questionCandidates = questionData['candidates'];
      final questionTitle = questionCandidates[0]['output'];

      print('Generated Question: $questionTitle');

      await generateSteps(questionTitle);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> generateSteps(String questionTitle) async {
    try {
      Dio dioClient = Dio();
      const url =
          'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
      final queryParameters = {
        'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"
      };

      final stepsPrompt = {
        'prompt': {
          'text': 'What are the steps or key concepts for $questionTitle?'
        },
      };

      final stepsResponse = await dioClient.post(
        url,
        queryParameters: queryParameters,
        data: stepsPrompt,
      );

      final Map<String, dynamic> stepsData = stepsResponse.data;
      final List<dynamic> stepsCandidates = stepsData['candidates'];

      generatedSteps = stepsCandidates
          .map((stepCandidate) => stepCandidate['output'].toString())
          .toList();

      // Replace "**" with " "
      generatedSteps =
          generatedSteps.map((step) => step.replaceAll('**', ' ')).toList();

      print('Generated Steps: $generatedSteps');
    } catch (e) {
      print('Error generating steps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Creator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's help you with educational content! :D",
              style: GoogleFonts.poppins(fontSize: 22),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _subjectController,
              labelText: "Please enter the subject.",
              hintText: "Enter subject.",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _classController,
              labelText: "Please enter the class.",
              hintText: "Enter class.",
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedDifficulty,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDifficulty = newValue!;
                });
              },
              items: <String>['Easy', 'Medium', 'Hard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Difficulty Level'),
            ),
            const SizedBox(height: 15),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await generateTrack(
                  _subjectController.text,
                  _selectedDifficulty,
                  selectedBtn == 0 ? true : false,
                );
                setState(() {});
              },
              child: Text('Generate Steps and Tracks'),
            ),
            const SizedBox(height: 20),
            if (generatedSteps.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Generated Steps:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  for (int i = 0; i < generatedSteps.length; i++)
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          'Step ${i + 1}:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          generatedSteps[i].replaceAll('**', ' '),
                        ),
                        leading: Icon(Icons.check_circle),
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

