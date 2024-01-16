import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:learnflow/common/text_field/custom_text_field.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart' as mypdf;
import 'package:pdf_render/pdf_render.dart';

import '../../common/constants/constants.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({Key? key}) : super(key: key);

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  final _studyContentController = TextEditingController();
  String scannedText = "";
  String _generatedNotes = "";
  File? imageFile;

  void pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.first.path!);
      await renderPdf(file);
      setState(() {});
    }
  }

  Future<void> renderPdf(File pdfFile) async {
    final document = await PdfDocument.openFile(pdfFile.path);
    final page = await document.getPage(1);

    final pageImage = await page.render(
      width: int.parse(page.width as String),
      height: int.parse(page.height as String),
    );

    final tempDir = Directory.systemTemp;
    final tempPdf = File('${tempDir.path}/temp_pdf.jpeg');
    await tempPdf.writeAsBytes(pageImage as List<int>);

    imageFile = tempPdf;
  }

  void generateNotes() async {
    Dio dioClient = Dio();

    const url =
        'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

    final queryParameters = {'key': "AIzaSyCH1Jk6k-IM7jue010oexQLSxOzaC2RpGE"};
    final body = {
      'prompt': {
        'text':
            '(makes notes like a mindmap graph, genz friend), make notes for the text $scannedText',
      },
    };

    final response =
        await dioClient.post(url, queryParameters: queryParameters, data: body);

    Map<String, dynamic> responseData = response.data;

    List<dynamic> candidates = responseData['candidates'];

    String output = candidates[0]['output'];
    output = output.replaceAll('`', '');

    output = output.replaceAll('*', '');
    output = output.replaceAll('#', '');

    _generatedNotes = output;
    setState(() {});
  }

  void getRecognizedText() async {
    final inputImage = InputImage.fromFilePath(imageFile!.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
      setState(() {});
    }

    generateNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _studyContentController.dispose();
  }

  void makeNotes(BuildContext context) {
    if (_studyContentController.text.isEmpty && imageFile == null) {
      showSnackBar(context,
          "Please input your study content or upload an image or PDF.");
    } else {
      if (imageFile == null && _studyContentController.text.isNotEmpty) {
        // Make notes from text content
        scannedText = _studyContentController.text;
        generateNotes();
      } else if (imageFile != null) {
        // Make notes from image content
        getRecognizedText();
      }
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
                  "Let's create study notes.",
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
                    "Make notes!",
                    style: GoogleFonts.archivoNarrow(
                        color: Pallete().buttonTextColor, fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your generated notes:",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: Column(
                  children: [
                    Text(_generatedNotes),
                    Container(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
