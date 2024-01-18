import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnflow/common/flash_card_widget/flash_card_widget.dart';
import 'package:learnflow/features/home/home_screen.dart';

import '../../utils/utils.dart';

class FlashCardTemplate extends StatefulWidget {
  final String fullText;
  const FlashCardTemplate({super.key, required this.fullText});

  @override
  State<FlashCardTemplate> createState() => _FlashCardTemplateState();
}

class _FlashCardTemplateState extends State<FlashCardTemplate> {
  List<String> quotes = [];
  String _generatedNotes = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
    createFlashCardQuotes();
  }

  void createFlashCardQuotes() async {
    Dio dioClient = Dio();

    print('inside text is ${widget.fullText}');

    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

    final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};
    final body = {
      'prompt': {
        'text':
            ' ${widget.fullText} get keypoints, convert them into sentences (10 sentences) all divided by a comma',
      },
    };

    final response =
        await dioClient.post(url, queryParameters: queryParameters, data: body);

    Map<String, dynamic> responseData = response.data;

    List<dynamic> candidates = responseData['candidates'];

    String output = candidates[0]['output'];
    print('the output is $output');

    _generatedNotes = output;
    print('the inner text is ${_generatedNotes}');
    quotes = _generatedNotes.split(',');

    setState(() {
      print(quotes);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FlashCardWidget(
                onTap: () {
                  if (index < quotes.length - 1) {
                    // Increment index if there are more sentences
                    index++;
                    setState(() {});
                  } else {
                    moveScreen(context, HomeScreen(), isPushReplacement: true);
                  }
                },
                text: quotes.isNotEmpty ? quotes[index] : "No quotes available",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
