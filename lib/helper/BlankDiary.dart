

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:soulvoyage/component/toast.dart';
import 'dart:convert';
import 'package:toastification/toastification.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soulvoyage/screen/dashboard/Entries/Entries.dart';

class BlankDiary{

  final TextEditingController title;
  final TextEditingController diary;
  BlankDiary({required this.title, required this.diary});

  Future<void> blankDiaryEntry() async {

    // get from SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final  email = prefs.getString('email'); 
          final createdDate = DateTime.now().toUtc().toIso8601String();
    final body = jsonEncode({
      'title': title.text,
      'journalEntry': diary.text,
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




class UpdateDiary{
  final String? id;
  final TextEditingController title;
  final TextEditingController diary;
  UpdateDiary( {required this.title, required this.diary,required this.id});

  Future<void> updateDiaryEntry() async {

    // get from SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final  email = prefs.getString('email'); 
          final token = prefs.getString('jwttoken');
          final createdDate = DateTime.now().toUtc().toIso8601String();
    final body = jsonEncode({
      'title': title.text,
      'journalEntry': diary.text,
      'userEmailAddress': email,
      'createdDate':createdDate,
      'modifiedDate':createdDate
    });

    try {
      
      print("this is id $id");
      
        final response = await http.patch(
        Uri.parse('$journalEntryUpdate/$id'),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        // final responseData = json.decode(response.body);
        Get.offAll(()=> const Entries(), transition:  Transition.noTransition);
        showCustomToast(title: 'Diary update successfully', type: ToastificationType.success);
        
        
      //  print(responseData);
      } else {
        showCustomToast(title: 'Server error: ${response.statusCode}', type: ToastificationType.error);
        
        
      }
      
    } catch (e) {
      showCustomToast(title: 'An error occurred: $e', type: ToastificationType.error);
    }
  }



}