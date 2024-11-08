import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/component/defaultButton.dart';
import 'package:soulvoyage/component/defaultInput.dart';
import 'package:soulvoyage/component/defaultPassword.dart';
import 'package:soulvoyage/helper/Registration.dart';
import 'package:soulvoyage/screen/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  bool loadingBtn = false;

  // Error message variables
  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  // Validate the input fields
  bool validateInputs() {
    bool isValid = true;

    setState(() {
      if (nameController.text.isEmpty) {
        nameErrorText = "Name is required";
        isValid = false;
      } else {
        nameErrorText = null;
      }

      if (emailController.text.isEmpty) {
        emailErrorText = "Email is required";
        isValid = false;
      } else if (!emailController.text.isEmail) {
        emailErrorText = "Please enter a valid email";
        isValid = false;
      } else {
        emailErrorText = null;
      }

      if (passwordController.text.isEmpty) {
        passwordErrorText = "Password is required";
        isValid = false;
      } else if (passwordController.text.length < 6) {
        passwordErrorText = "Password must be at least 6 characters";
        isValid = false;
      } else {
        passwordErrorText = null;
      }

      if (confirmPasswordController.text.isEmpty) {
        confirmPasswordErrorText = "Confirm Password is required";
        isValid = false;
      } else if (passwordController.text != confirmPasswordController.text) {
        confirmPasswordErrorText = "Passwords do not match";
        isValid = false;
      } else {
        confirmPasswordErrorText = null;
      }
    });

    return isValid;
  }

@override
void dispose() {
  nameController.dispose(); // Dispose animations or controllers
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(195),
                      bottomRight: Radius.circular(195),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/Images/signup.png', // Replace with your PNG file path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: size.width * 0.3,
                      height: 2,
                      color: kBorderColor,
                    ),
                     Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w700,
                        color: kTextColor,
                      ),
                    ),
                    Container(
                      width: size.width * 0.3,
                      height: 2,
                      color: kBorderColor,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                DefaultInputField(
                  labelText: "Name",
                  controller: nameController,
                  errorText: nameErrorText,
                ),
                DefaultInputField(
                  labelText: "Email",
                  controller: emailController,
                  errorText: emailErrorText,
                ),
                PasswordInputField(
                  labelText: "Password",
                  controller: passwordController,
                  errorText: passwordErrorText,
                ),
                PasswordInputField(
                  labelText: "Confirm Password",
                  controller: confirmPasswordController,
                  errorText: confirmPasswordErrorText,
                ),
                const SizedBox(height: 20),
                DefaultButton(
                  onPressed: () async {
                    if(!loadingBtn){

                     if (mounted) {
                        setState(() {
                          loadingBtn = true;
                        });
                      }
                    if (validateInputs()) {
                     

                      await Future.delayed(const Duration(seconds: 1));
                      Register(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                      ).register();
                      await Future.delayed(const Duration(seconds: 3));

                    }
                     if (mounted) {
                      setState(() {
                        loadingBtn = false;
                      });
                    }
                    }else{
                      return null;
                    }
                  },
                  name: !loadingBtn
                      ?  Text("SIGN UP", style: TextStyle(fontSize: size.width * 0.05))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "LOADING...",
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          ],
                        ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: kBorderColor,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const LoginScreenWithBackExit());
                      },
                      child:  Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: size.width* 0.05,
                          color: kButtonColor,
                          decoration: TextDecoration.underline,
                          decorationColor: kButtonColor,
                        ),
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
