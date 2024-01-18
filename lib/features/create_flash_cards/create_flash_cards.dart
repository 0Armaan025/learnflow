import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/flash_card_widget/flash_card_widget.dart';
import 'package:learnflow/features/create_flash_cards/flash_card_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as gKit;
import 'package:learnflow/common/text_field/custom_text_field.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../common/constants/constants.dart';

class CreateFlashCardsScreen extends StatefulWidget {
  const CreateFlashCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreateFlashCardsScreen> createState() => _CreateFlashCardsScreenState();
}

class _CreateFlashCardsScreenState extends State<CreateFlashCardsScreen> {
  final _studyContentController = TextEditingController();
  String scannedText = "";
  String _generatedNotes = "";
  File? imageFile;
  File? pdfFile;

  void pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.first.path!);

      setState(() {
        pdfFile = file;
        showSnackBar(context, "Pdf file picked!");
      });
      extractText();
    }
  }

  void extractText() async {
    final PdfDocument document =
        PdfDocument(inputBytes: File(pdfFile!.path).readAsBytesSync());
    PdfTextExtractor extractor = PdfTextExtractor(document);

    String text = extractor.extractText();
    _generatedNotes = text;
    setState(() {});
    generateNotes(_generatedNotes);
  }

  void generateNotes(String scannedText) async {
    Dio dioClient = Dio();

    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

    final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};
    final body = {
      'prompt': {
        'text':
            '$scannedText get keypoints, convert them into sentences (10 sentences) all divided by a comma',
      },
    };

    final response =
        await dioClient.post(url, queryParameters: queryParameters, data: body);

    Map<String, dynamic> responseData = response.data;

    List<dynamic> candidates = responseData['candidates'];

    String output = candidates[0]['output'];
    output = output.replaceAll('`', '');

    _generatedNotes = output;
    setState(() {});
  }

  void getRecognizedText(File imageFile) async {
    final inputImage = gKit.InputImage.fromFilePath(imageFile.path);
    final textDetector = gKit.GoogleMlKit.vision.textRecognizer();
    gKit.RecognizedText recognizedText =
        await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";

    for (gKit.TextBlock block in recognizedText.blocks) {
      for (gKit.TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
      setState(() {
        print('the text in the image is $scannedText');
      });
    }
    generateNotes(scannedText);
  }

  @override
  void dispose() {
    super.dispose();
    _studyContentController.dispose();
  }

  void makeNotes(BuildContext context) {
    imageFile = null;
    setState(() {
      scannedText = "";
    });
    if (imageFile == null && _studyContentController.text.isNotEmpty) {
      // Make notes from text content
      scannedText = _studyContentController.text;
      generateNotes(scannedText);
    } else if (imageFile != null) {
      // Make notes from image content
      getRecognizedText(imageFile!);
    } else {
      scannedText = _studyContentController.text;
      generateNotes(scannedText);
    }
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
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Let's create flash cards.",
                  style: GoogleFonts.poppins(
                    color: Pallete().headlineTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: size.height * 0.2,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: imageFile == null
                      ? IconButton(
                          icon: Icon(Icons.add_a_photo,
                              color: Colors.white, size: 40),
                          onPressed: () async {
                            final pickedFile = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );

                            if (pickedFile != null) {
                              imageFile = File(pickedFile.path);
                              setState(() {});
                            }
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(imageFile!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 30),
                child: IconButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      imageFile = File(pickedFile.path);
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 30),
                child: IconButton(
                  onPressed: () {
                    pickFile(context); // Open file picker for PDF

                    setState(() {});
                  },
                  icon: const Icon(Icons.insert_drive_file),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  "Or, you can input\nyour study material\nhere manually.",
                  style: GoogleFonts.lato(
                      fontSize: 22, color: Pallete().headlineTextColor),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                    controller: _studyContentController,
                    labelText: "Your study content.",
                    hintText: "Enter your study content",
                    keyboardType: TextInputType.multiline,
                    maxLines: null),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  makeNotes(context);
                  moveScreen(context, FlashCardTemplate(fullText: scannedText),
                      isPushReplacement: true);
                },
                child: Container(
                  height: size.height * 0.08,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Pallete().buttonColor,
                  ),
                  child: Text(
                    "Make flash cards!",
                    style: GoogleFonts.archivoNarrow(
                        color: Pallete().buttonTextColor, fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
