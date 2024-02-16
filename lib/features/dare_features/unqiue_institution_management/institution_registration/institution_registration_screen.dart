import 'package:flutter/material.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class InstitutionRegistrationScreen extends StatefulWidget {
  const InstitutionRegistrationScreen({super.key});

  @override
  State<InstitutionRegistrationScreen> createState() => _InstitutionRegistrationScreenState();
}

class _InstitutionRegistrationScreenState extends State<InstitutionRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}