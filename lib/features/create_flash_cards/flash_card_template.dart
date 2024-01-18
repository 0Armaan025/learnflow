import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnflow/common/flash_card_widget/flash_card_widget.dart';
import 'package:learnflow/features/home/home_screen.dart';

import '../../common/constants/constants.dart';
import '../../utils/utils.dart';

class FlashCardTemplate extends StatefulWidget {
  final String fullText;
  final List<String> quotes;

  const FlashCardTemplate(
      {super.key, required this.fullText, required this.quotes});

  @override
  State<FlashCardTemplate> createState() => _FlashCardTemplateState();
}

class _FlashCardTemplateState extends State<FlashCardTemplate> {
  String _generatedNotes = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
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
                  if (index < widget.quotes.length - 1) {
                    // Increment index if there are more sentences
                    index++;
                    setState(() {});
                  } else {
                    moveScreen(context, HomeScreen(), isPushReplacement: true);
                  }
                },
                text: widget.quotes.isNotEmpty
                    ? widget.quotes[index]
                    : "No quotes available",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
