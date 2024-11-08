

import 'package:flutter/material.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:toastification/toastification.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:soulvoyage/component/constatnt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soulvoyage/screen/dashboard/Entries/Entries.dart';

class SlowMovement{
  final String title;
  final TextEditingController entry1;
  final TextEditingController entry2;
  final TextEditingController entry3;
  final TextEditingController entry4;
  final TextEditingController entry5;
  final TextEditingController entry6;
  SlowMovement( {required this.title, required this.entry1,required this.entry2,required this.entry3,required this.entry4,required this.entry5,required this.entry6,});

  Future<void> slowMovementEntry() async {

    // get from SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final  email = prefs.getString('email'); 
          final createdDate = DateTime.now().toUtc().toIso8601String();
    final body = jsonEncode({
      'title': title,
      'journalEntry': 'Move slowly in a relaxed manner. Keep strolling, then suddenly stop moving. Be still, focus on your body as much as you can.\n 1. What did you feel?\n${entry1.text} \n 2. What emotions did you feel?\n${entry2.text}\n 3. What thoughts have come into your mind?\n${entry3.text}\n 4. Imagine being the healthiest person. Walk and then freeze.\n${entry4.text}\n 5. What emotions did you feel?\n${entry5.text}\n 6. What sensations do you feel?\n${entry6.text}',
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