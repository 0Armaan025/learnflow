import 'package:flutter/material.dart';
import 'package:learnflow/utils/utils.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            
            children: [
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
