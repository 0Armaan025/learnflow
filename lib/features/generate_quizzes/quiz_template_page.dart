import 'package:flutter/material.dart';
import 'package:learnflow/common/dare_feature_tile/quiz_card.dart';
import 'package:learnflow/utils/utils.dart';

import '../../utils/pallete.dart';

class QuizTemplatePage extends StatefulWidget {
  final String data;
  
  const QuizTemplatePage({super.key, required this.data});

  @override
  State<QuizTemplatePage> createState() => _QuizTemplatePageState();
}

class _QuizTemplatePageState extends State<QuizTemplatePage> {

  @override
  void initState() {
    super.initState();
    // getQuestionsAndOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              QuizCard(scannedText: widget.data,),
            ],
          ),
        ),
      ),
    );
  }
}
