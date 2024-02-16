import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:learnflow/common/constants/constants.dart';
import 'package:learnflow/features/database/institution/models/institution.dart';

class InstitutionRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> registerInstitution(InstitutionModel model, ) async {
    try {
      // Upload image to Firebase Storage
      String imageUrl = await _uploadImage(model.name,);

      // Generate a special code for uniqueCode field
      String uniqueCode = _generateSpecialCode();

      // Create a new model with the updated image URL and special code
      InstitutionModel newModel = model.copyWith(
        imageUrl: imageUrl,
        uniqueCode: uniqueCode,
      );

      // Store the new model in Firestore
      await firestore.collection('institutions').doc(model.name).set(newModel.toMap());
    } catch (e) {
      print('Error registering institution: $e');
      // Handle error accordingly
    }
  }

  Future<String> _uploadImage(String imageName) async {
    try {
      Reference storageReference =
          _storage.ref().child('institution_images/$imageName.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile!);

      await uploadTask.whenComplete(() => null);

      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error accordingly
      return '';
    }
  }

  String _generateSpecialCode() {
    // Generate a special code of length 6
    String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()-_=+[{]}|;:\'",<.>/?';
    Random random = Random();
    String specialCode = '';
    for (int i = 0; i < 6; i++) {
      specialCode += characters[random.nextInt(characters.length)];
    }
    return specialCode;
  }
}
