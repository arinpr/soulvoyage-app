import 'package:flutter/material.dart';

import 'package:soulvoyage/component/dashboardButton.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:soulvoyage/helper/BlankDiary.dart';

import 'package:toastification/toastification.dart';

class BlankDiaryScreen extends StatefulWidget {
  const BlankDiaryScreen({super.key});

  @override
  State<BlankDiaryScreen> createState() => _BlankDiaryScreenState();
}

class _BlankDiaryScreenState extends State<BlankDiaryScreen> {
  var titleController = TextEditingController();
  var diaryController = TextEditingController();

  bool loadingBtn = false;

  @override
  void dispose() {
    titleController.dispose(); // Dispose animations or controllers
    diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // final screenHeight = MediaQuery.of(context).size.height;
    // final int maxLinesForDiaryEntry = (screenHeight / 40).floor();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the screen
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch text fields to full width
          children: [
            // Title TextField (Single line)
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title', // Label for the title field
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20), // Space between fields

            // Diary Entry TextField (Multi-line)
            Expanded(
              child: TextField(
                controller: diaryController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Write here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: null, // Make TextField flexible in height
                expands:
                    true, // Allows the TextField to take all available space
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DashboardButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    diaryController.text.isEmpty) {
                    showCustomToast(
                      
                      title: 'Please fill all the fields',
                      type: ToastificationType.error,
                    );

                } else {
                  if (!loadingBtn) {
                    if (mounted) {
                      setState(() {
                        loadingBtn = true;
                      });
                    }
                    await Future.delayed(const Duration(seconds: 1));
                    BlankDiary(title: titleController, diary: diaryController)
                        .blankDiaryEntry();
                    await Future.delayed(const Duration(seconds: 5));

                    if (mounted) {
                      setState(() {
                        loadingBtn = false;
                      });
                    }
                  } else {
                    return null;
                  }
                }
              },
              name: !loadingBtn
                  ? const Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 22),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "LOADING...",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
