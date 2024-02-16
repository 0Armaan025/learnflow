import 'dart:io';
import 'package:learnflow/features/database/institution/models/institution.dart';
import 'package:learnflow/features/database/institution/repositories/institution_repository.dart';


class InstitutionRegistrationController {
  final InstitutionRepository _institutionRepository;

  InstitutionRegistrationController(this._institutionRepository);

  Future<void> registerInstitution(InstitutionModel institution) async {
    try {
      // Call the registerInstitution method in the repository
      await _institutionRepository.registerInstitution(institution);
    } catch (e) {
      print('Error registering institution: $e');
      // Handle error accordingly
    }
  }
}
