

import 'package:flutter/material.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:toastification/toastification.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:soulvoyage/component/constatnt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soulvoyage/screen/dashboard/Entries/Entries.dart';

class SafeSpace{
  final String title;
  final TextEditingController entry1;
  final TextEditingController entry2;
  final TextEditingController entry3;
  final TextEditingController entry4;
  final TextEditingController entry5;
  final TextEditingController entry6;
  SafeSpace( {required this.title, required this.entry1,required this.entry2,required this.entry3,required this.entry4,required this.entry5,required this.entry6,});

  Future<void> safeSpaceEntry() async {

    // get from SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final  email = prefs.getString('email'); 
          final createdDate = DateTime.now().toUtc().toIso8601String();
    final body = jsonEncode({
      'title': title,
      'journalEntry': '1. What makes you feel safe? \n ${entry1.text} \n 2. Are there places where you feel safe? Describe below. \n${entry2.text}\n 3. Briefly describe your ideal safe place... \n${entry3.text}\n 4. What sensations do you feel in your safe place? \n${entry4.text}\n 5. Describe the outside noise effect... \n${entry5.text}\n 6. Write a paragraph about how you feel...\n${entry6.text}',
      'userEmailAddress': email,
      'createdDate':createdDate,
      'modifiedDate':createdDate
    });

    try {
      
      // print("this is body $body");
      
        final response = await http.post(
        Uri.parse(journalEntry),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        // final responseData = json.decode(response.body);
        Get.offAll(()=> const Entries(), transition: Transition.noTransition);
      //  print(responseData);
      } else {
        showCustomToast(title: 'Server error: ${response.statusCode}', type: ToastificationType.error);
      }
      
    } catch (e) {
      showCustomToast(title: 'An error occurred: $e', type: ToastificationType.error);
      
      
    }
  }



}