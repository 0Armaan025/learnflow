import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class QuizCard extends StatefulWidget {
  final String scannedText;
  const QuizCard({Key? key, required this.scannedText}) : super(key: key);

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String answer;
  late String questionTitle;
  String statusText = "";
  String selectedOption = "";
  
  late Future<void> questionFuture;

  @override
  void initState() {
    super.initState();
    questionFuture = getQuestionAndAnswer(widget.scannedText);
  }

  Future<void> getQuestionAndAnswer(String scannedText) async {
    Dio dioClient = Dio();
    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
    final queryParameters = {
      'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"
    };

    try {
      final questionBody = {
        'prompt': {
          'text':
              'What are the questions that can be made on the basis of (just say one question): $scannedText'
        },
      };
      final questionResponse = await dioClient.post(
        url,
        queryParameters: queryParameters,
        data: questionBody,
      );
      final Map<String, dynamic> questionData = questionResponse.data;
      final List<dynamic> questionCandidates = questionData['candidates'];
      questionTitle = questionCandidates[0]['output'];

      print('Generated Question: $questionTitle');

      await getOptions(questionTitle);
    } catch (e) {
      print('Error: $e');
      // Handle error accordingly
    }
  }

  Future<String> getOption(String prompt) async {
    Dio dioClient = Dio();
    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';
    final queryParameters = {
      'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"
    };

    try {
      String option = "";
      int retryCount = 0;
      const maxRetries = 3;

      while ((option.isEmpty || option == "null") && retryCount < maxRetries) {
        final optionBody = {'prompt': {'text': prompt}};
        final optionResponse = await dioClient.post(
            url, queryParameters: queryParameters, data: optionBody);

        print('Option Response: $optionResponse'); // Add this line for debugging

        final Map<String, dynamic>? optionData = optionResponse.data;

        if (optionData != null) {
          final List<dynamic>? optionCandidates = optionData['candidates'];

          if (optionCandidates != null && optionCandidates.isNotEmpty) {
            option = optionCandidates[0]['output'] ?? "";
          } else {
            print(
                'Error: No candidates found in the response for prompt: $prompt');
          }
        } else {
          print('Error: Unexpected response structure for prompt: $prompt');
        }

        retryCount++;
      }

      if (retryCount == maxRetries) {
        print(
            'Error: Unable to fetch a non-empty option after $maxRetries retries');
      }

      return option;
    } catch (e) {
      print('Error fetching option: $e');
      return "";
    }
  }

  Future<void> getOptions(String questionTitle) async {
    option1 = await getOption(
            'Just answer in one word, give options for this question (1st option), $questionTitle') ??
        "";
    option2 = await getUniqueOption(
        'Just answer in one word, give options for this question (2nd option), $questionTitle.',
        [option1]);
    option3 = await getUniqueOption(
        'Just answer in one word, give options for this question (3rd and correct option), $questionTitle.',
        [option1, option2]);
    option4 = await getUniqueOption(
        'Just answer in one word, give options for this question (4th option), $questionTitle.',
        [option1, option2, option3]);

    setState(() {
      answer = option3;

      print('Option 1: $option1');
      print('Option 2: $option2');
      print('Option 3: $option3');
      print('Option 4: $option4');
      print('Correct Answer: $answer');
    });
  }

  Future<String> getUniqueOption(String prompt, List<String> previousOptions) async {
    String newOption = await getOption(prompt) ?? "";

    while (previousOptions.contains(newOption)) {
      newOption = await getOption(prompt) ?? "";
    }

    return newOption;
  }

  void submitAnswer() {
    if (selectedOption == answer) {
      statusText = "Correct!";
      score++;
      getNewQuestion();
    } else {
      statusText = "Wrong!";
    }
  }

  void getNewQuestion() {
    setState(() {
      selectedOption = "";
      statusText = "";
      questionFuture = getQuestionAndAnswer(widget.scannedText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: questionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          height: size.height * 0.7,
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$questionTitle",
                style: GoogleFonts.poppins(
                  color: Pallete().headlineTextColor,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      selectedOption = option1;
                      setState(() {});
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Pallete().buttonColor,
                      ),
                      child: Text(
                        "${option1}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Pallete().buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      selectedOption = option2;
                      setState(() {});
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Pallete().buttonColor,
                      ),
                      child: Text(
                        "${option2}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Pallete().buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      selectedOption = option3;
                      setState(() {});
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Pallete().buttonColor,
                      ),
                      child: Text(
                        "${option3}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Pallete().buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      selectedOption = option4;
                      setState(() {});
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Pallete().buttonColor,
                      ),
                      child: Text(
                        "${option4}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Pallete().buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (selectedOption.isNotEmpty) {
                            submitAnswer();
                            
                          } else {
                            setState(() {
                              statusText =
                                  "Please select an option before submitting.";
                            });
                          }
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Pallete().buttonColor,
                          ),
                          child: Text(
                            "Submit ->",
                            style: GoogleFonts.roboto(
                                color: Pallete().buttonTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("$statusText",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Pallete().headlineTextColor)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
