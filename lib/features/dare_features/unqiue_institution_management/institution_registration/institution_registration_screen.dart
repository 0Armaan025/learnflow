import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/constants/constants.dart';
import 'package:learnflow/features/database/institution/models/institution.dart';
import 'package:learnflow/features/database/institution/repositories/institution_repository.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class InstitutionRegistrationScreen extends StatefulWidget {
  const InstitutionRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<InstitutionRegistrationScreen> createState() =>
      _InstitutionRegistrationScreenState();
}

class _InstitutionRegistrationScreenState
    extends State<InstitutionRegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _establishmentDateController = TextEditingController();
  TextEditingController _licenseNumberController = TextEditingController();
  TextEditingController _affiliationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _socialMediaController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Pallete().bgColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Text("Institution Registration",
                    style: GoogleFonts.aleo(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    pickImage(context);
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 20),
              buildTextField("Institution Name", _nameController),
              buildTextField("Institution Code", _codeController),
              buildTextField("Email Address", _emailController),
              buildTextField("Phone Number", _phoneController),
              buildTextField("Address", _addressController),
              buildTextField("Type of Institution", _typeController),
              buildTextField("Establishment Date", _establishmentDateController),
              buildTextField("License Number", _licenseNumberController),
              buildTextField("Affiliation", _affiliationController),
              buildTextField("Description/About", _descriptionController),
              buildTextField("Social Media Links", _socialMediaController),
              buildTextField("Website URL", _websiteController),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    registerInstitution();
                    
                  },
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.08,
                    margin: const EdgeInsets.symmetric(horizontal: 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Pallete().buttonColor,
                    ),
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                        color: Pallete().buttonTextColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void registerInstitution() async {
    // Create an instance of InstitutionRepository
    InstitutionRepository repository = InstitutionRepository();

    // Create an instance of InstitutionModel with the form data
    InstitutionModel model = InstitutionModel(
      name: _nameController.text,
      code: _codeController.text,
      email: _emailController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      affiliation: _affiliationController.text,
      description: _descriptionController.text,
      establishmentCode: _establishmentDateController.text,
      imageUrl: '',
      licenseNumber: _licenseNumberController.text,
      socialMedia: _socialMediaController.text,
      type: _typeController.text,
      uniqueCode: '',
      website: _websiteController.text,

    );

    // Call the registerInstitution method of the repository
    await repository.registerInstitution(model);
  }
}
