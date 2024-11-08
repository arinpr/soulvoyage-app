

import 'package:flutter/material.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:toastification/toastification.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:soulvoyage/component/constatnt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soulvoyage/screen/dashboard/Entries/Entries.dart';

class GriefJournaling{
  final String title;
  final TextEditingController entry1;
  final TextEditingController entry2;
  final TextEditingController entry3;
  final TextEditingController entry4;
  final TextEditingController entry5;
  final TextEditingController entry6;
  final TextEditingController entry7;
  GriefJournaling( {required this.title, required this.entry1,required this.entry2,required this.entry3,required this.entry4,required this.entry5,required this.entry6,required this.entry7});

  Future<void> griefJournalingEntry() async {

    // get from SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final  email = prefs.getString('email'); 
          final createdDate = DateTime.now().toUtc().toIso8601String();
    final body = jsonEncode({
      'title': title,
      'journalEntry': '1. Remember a trauma and your shock. Describe how you felt.\n${entry1.text} \n 2. How did you deny the trauma? Describe how you felt.\n${entry2.text}\n 3. Describe your initial reactions to the trauma.\n${entry3.text}\n 4. Describe the pain you felt from the trauma.\n${entry4.text}\n 5. How did you come to accept the trauma?\n${entry5.text}\n 6. Describe the way you said goodbye to the trauma.\n${entry6.text}\n 7. How did you learn to be grateful after the trauma?\n${entry7.text}',
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
        showCustomToast(title: 'Diary entry successfully', type: ToastificationType.success);
      //  print(responseData);
      } else {
        showCustomToast(title: 'Server error: ${response.statusCode}', type: ToastificationType.error);
        
       
      }
      
    } catch (e) {
       showCustomToast(title: 'An error occurred: $e', type: ToastificationType.error);
      
    }
  }



}