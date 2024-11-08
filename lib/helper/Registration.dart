import 'package:flutter/material.dart';
import 'package:soulvoyage/component/toast.dart';
import 'dart:convert';

import 'package:toastification/toastification.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:http/http.dart' as http;
import 'package:soulvoyage/screen/dashboard/Dashboard.dart';

class Register{

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;


  Register({required this.nameController, required this.emailController,required this.passwordController});

  Future<void> register() async {
    final body = jsonEncode({
      'userName': nameController.text,
      'email':emailController.text,
      'password': passwordController.text
      
    });

    try {
      final response = await http.post(
        Uri.parse(registerAPI), // Change this to your registration API endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['status'] == 'success') {
            String email = responseData['message']['email'];
            String userName = responseData['message']['userName'];
            String jwtToken = responseData['message']['jwttoken'];

            // Save in SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('email', email);
            await prefs.setString('userName', userName);
            await prefs.setString('jwttoken', jwtToken);

            // Navigate to the next screen (e.g., dashboard)
            Get.offAll(() => const Dashboard(), transition: Transition.rightToLeft);
          } else {
            
            showCustomToast(title: 'Registration failed: ${responseData['message']['errorMessage']}', type: ToastificationType.error);
            
            
          }
        } else {
          showCustomToast(title: 'Server error: ${response.statusCode}', type: ToastificationType.error);
          
          
        }
      
    } catch (e) {
      showCustomToast(title: 'An error occurred: $e', type: ToastificationType.error);
      
      
    }
  }
}