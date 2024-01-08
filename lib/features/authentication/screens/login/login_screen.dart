import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/common/button/custom_signup_button.dart';
import 'package:learnflow/common/text_field/custom_text_field.dart';
import 'package:learnflow/features/authentication/screens/signup/signup_screen.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/constants/constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                    "Log-in",
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
              Text(
                "We are happy to see you all come back! 🔥",
                style: GoogleFonts.poppins(color: Pallete().headlineTextColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Lottie.asset('assets/lottie/login_animation.json'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        controller: _emailController,
                        labelText: "Email",
                        hintText: "Your email-id"),
                    CustomTextField(
                        controller: _passwordController,
                        isObscure: true,
                        labelText: "Password",
                        hintText: "Password"),
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
                            "New to $appName?",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              moveScreen(context, SignUpScreen(),
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
                  text: 'Log in',
                  onPressed: () {},
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
