import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/dare_feature_tile/dare_feature_tile.dart';
import 'package:learnflow/features/dare_features/progress_creator/progress_creator_screen.dart';
import 'package:learnflow/features/dare_features/unqiue_institution_management/institution_registration/institution_registration_screen.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class DareFeaturesScreen extends StatefulWidget {
  const DareFeaturesScreen({super.key});

  @override
  State<DareFeaturesScreen> createState() => _DareFeaturesScreenState();
}

class _DareFeaturesScreenState extends State<DareFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              buildAppBar(context),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "DARE Features!🔥",
                  style: GoogleFonts.poppins(
                    color: Pallete().headlineTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DareFeatureTile(
                bannerImage:
                    'https://plus.unsplash.com/premium_photo-1676998931123-75789162f170?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZWR1Y2F0aW9ufGVufDB8fDB8fHww',
                titleText: "Super EduTracks",
                descriptionText:
                    "Have practical super edutracks to get practical knowledge!",
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  moveScreen(context, InstitutionRegistrationScreen());
                },
                child: DareFeatureTile(
                  titleText: "Unique Institution\nsystem",
                  bannerImage:
                      'https://media.istockphoto.com/id/1460007178/photo/library-books-on-table-and-background-for-studying-learning-and-research-in-education-school.jpg?s=1024x1024&w=is&k=20&c=cuzIXmvKHLpoGxGIft9zCiTw-jeL0Gjp7UNZau0MNkk=',
                  descriptionText:
                      "Have practical super edutracks to get practical knowledge!",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  moveScreen(context, ProgressCreatorScreen());
                },
                child: DareFeatureTile(
                  titleText: "AI-Generated\nTracks",
                  bannerImage:
                      'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8YWklMjBzdHVkeXxlbnwwfHwwfHx8MA%3D%3D',
                  descriptionText:
                      "Let's help you set up a track using AI! 🔥",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
