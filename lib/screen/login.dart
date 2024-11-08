import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/component/defaultButton.dart';
import 'package:soulvoyage/component/defaultInput.dart';
import 'package:soulvoyage/component/defaultPassword.dart';
import 'package:soulvoyage/helper/Authentication.dart';

import 'package:soulvoyage/screen/signup.dart';

class LoginScreenWithBackExit extends StatefulWidget {
  const LoginScreenWithBackExit({super.key});

  @override
  _LoginScreenWithBackExitState createState() => _LoginScreenWithBackExitState();
}

class _LoginScreenWithBackExitState extends State<LoginScreenWithBackExit> {
  DateTime? backPressTime;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loadingBtn = false;
 // State to track token loading status

  // Error message variables
  String? emailErrorText;
  String? passwordErrorText;


  // Function to validate inputs
  bool validateInputs() {
    bool isValid = true;

    setState(() {
      if (emailController.text.isEmpty) {
        emailErrorText = "Email is empty";
        isValid = false;
      } else {
        emailErrorText = null;
      }

      if (passwordController.text.isEmpty) {
        passwordErrorText = "Password is empty";
        isValid = false;
      } else {
        passwordErrorText = null;
      }
    });

    return isValid;
  }


@override
void dispose() {
  emailController.dispose(); // Dispose animations or controllers
  passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (backPressTime == null ||
            now.difference(backPressTime!) > const Duration(seconds: 2)) {
          backPressTime = now;
          Fluttertoast.showToast(
              msg: "Press again to exit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(195),
                        topRight: Radius.circular(195),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/Images/login.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: size.width * 0.3,
                        height: 2,
                        color: kBorderColor,
                      ),
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 30,
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
                  SizedBox(height: size.height * 0.02),
                  DefaultInputField(
                    errorText: emailErrorText,
                    labelText: "Email",
                    controller: emailController,
                  ),
                  // const SizedBox(height: 20),
                  PasswordInputField(
                    errorText: passwordErrorText,
                    labelText: "Password",
                    controller: passwordController,
                  ),
                  const SizedBox(height: 40),
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
                        Auth(
                          emailController: emailController,
                          passwordController: passwordController,
                        ).login();
                        await Future.delayed(const Duration(seconds: 5));
                       
                       if (mounted) {
                        setState(() {
                          loadingBtn = false;
                        });
                      }
                      }
                      
                      }else{
                        return null;
                      }
                       
                    },
                    name: !loadingBtn
                        ? const Text("SIGN IN",
                            style: TextStyle(fontSize: 22))
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("LOADING...",
                                  style: TextStyle(fontSize: 22)),
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
                  const SizedBox(height: 40),
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
                        "Don't have an account?",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(() => const SignUpScreen());
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color: kButtonColor,
                            decoration: TextDecoration.underline,
                            decorationColor: kButtonColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
