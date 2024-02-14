import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class QuizCard extends StatefulWidget {

  final String scannedText;
  const QuizCard({super.key, required this.scannedText});

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestion();
  }

  void getQuestion() {
    getQuestionAndAnswer(widget.scannedText);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            "${questionTitle}",
            style: GoogleFonts.poppins(
              color: Pallete().headlineTextColor,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Pallete().buttonColor,
                ),
                child: Text(
                  "${option1}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Pallete().buttonTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
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
                    fontSize: 18,
                    color: Pallete().buttonTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
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
                    fontSize: 18,
                    color: Pallete().buttonTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
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
                    fontSize: 18,
                    color: Pallete().buttonTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Pallete().buttonColor,
                    ),
                    child: Text("<- Back",style: GoogleFonts.roboto(color: Pallete().buttonTextColor),),
                  ),
                  const SizedBox(width: 5),
                   Container(
                    width: 120,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Pallete().buttonColor,
                    ),
                    child: Text("Submit ->",style: GoogleFonts.roboto(color: Pallete().buttonTextColor),),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("$statusText",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Pallete().headlineTextColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
