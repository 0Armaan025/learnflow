import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:learnflow/common/constants/constants.dart';
import 'package:learnflow/features/database/institution/models/institution.dart';

class InstitutionRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> registerInstitution(InstitutionModel model) async {
    try {
      // Create a new model without the image URL and unique code
      InstitutionModel newModel = model.copyWith(imageUrl: null, uniqueCode: null);

      // Store the new model in Firestore
      await firestore.collection('institutions').doc(newModel.name).set(newModel.toMap());

      // Upload image to Firebase Storage
      String imageUrl = await _uploadImage(model.name);

      // Generate a special code for uniqueCode field
      String uniqueCode = _generateSpecialCode();

      // Update the document with the image URL and unique code
      await firestore.collection('institutions').doc(newModel.name).update({
        'imageUrl': imageUrl,
        'uniqueCode': uniqueCode,
      });
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
