import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/button/custom_signup_button.dart';
import 'package:learnflow/common/text_field/custom_text_field.dart';
import 'package:learnflow/features/authentication/screens/login/login_screen.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

import '../../../../common/constants/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Sign-up",
                    style: GoogleFonts.almendra(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Pallete().headlineTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Stack(
                  children: [
                    imageFile == null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[100],
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  pickImage(context);
                                },
                                icon: Icon(Icons.add_a_photo),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(imageFile!),
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        controller: _nameController,
                        labelText: "Name",
                        hintText: "Your name"),
                    CustomTextField(
                        controller: _emailController,
                        labelText: "Email",
                        hintText: "Your email-id"),
                    CustomTextField(
                        controller: _passwordController,
                        isObscure: true,
                        labelText: "Password",
                        hintText: "Password"),
                    CustomTextField(
                        controller: _confirmPasswordController,
                        isObscure: true,
                        labelText: "Confirm Password",
                        hintText: "Re-enter password"),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Already a member?",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              moveScreen(context, LogInScreen(),
                                  isPushReplacement: true);
                            },
                            child: Text(
                              "\tClick here",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: CustomSignUpButton(
                  text: 'Sign up',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}