import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/text_field/custom_text_field.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'detector_view.dart';
import 'text_detector_painter.dart';

import '../../common/constants/constants.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  final _studyContentController = TextEditingController();

  var _script = TextRecognitionScript.latin;
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  Widget _buildDropdown() => DropdownButton<TextRecognitionScript>(
        value: _script,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (TextRecognitionScript? script) {
          if (script != null) {
            setState(() {
              _script = script;
              _textRecognizer.close();
              _textRecognizer = TextRecognizer(script: _script);
            });
          }
        },
        items: TextRecognitionScript.values
            .map<DropdownMenuItem<TextRecognitionScript>>((script) {
          return DropdownMenuItem<TextRecognitionScript>(
            value: script,
            child: Text(script.name),
          );
        }).toList(),
      );

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
    _studyContentController.dispose();
  }

  void makeNotes(BuildContext context) {
    if (_studyContentController.text.isEmpty && imageFile == null) {
      showSnackBar(
          context, "Please input your study content or upload an image.");
    } else {}
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
              Stack(children: [
                DetectorView(
                  title: 'Text Detector',
                  customPaint: _customPaint,
                  text: _text,
                  onImage: _processImage,
                  initialCameraLensDirection: _cameraLensDirection,
                  onCameraLensDirectionChanged: (value) =>
                      _cameraLensDirection = value,
                ),
              ]),
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
                          onPressed: () {
                            pickImage(context);
                            setState(() {});
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
                  onPressed: () {
                    pickImage(context);
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
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
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
