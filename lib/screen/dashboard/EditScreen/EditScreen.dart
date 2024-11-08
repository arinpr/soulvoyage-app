import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/component/dashboardButton.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:soulvoyage/helper/BlankDiary.dart';

import 'package:toastification/toastification.dart';

class EditDiaryScreen extends StatefulWidget {
  final String? id;
  final String? title;
  final String? journalEntry;
  const EditDiaryScreen({
    super.key,
    this.journalEntry,
    this.title,
    required this.id,
  });

  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  var titleController = TextEditingController();
  var diaryController = TextEditingController();

  bool loadingBtn = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title ?? "");
    diaryController = TextEditingController(text: widget.journalEntry ?? "");
  }

  @override
  void dispose() {
    titleController.dispose();
    diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final screenHeight = MediaQuery.of(context).size.height;
    // final int maxLinesForDiaryEntry = (screenHeight / 40).floor();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 60,
            leading: Padding(
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: Colors.black12)
                    ] // Circle background color
                    ),
                child: IconButton(
                  iconSize: 20, // Adjust icon size if needed
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: kTextColor), // Icon color set to white
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(const Duration(milliseconds: 30));
                    Get.back();
                  },
                  highlightColor: const Color.fromARGB(255, 199, 217, 234),
                ),
              ),
            ),
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.07,
                ),
                Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'SoulVoyage',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kTextColor),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: kPageColor,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding for the screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Stretch text fields to full width
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
                            title: 'Please fill all the blank',
                            type: ToastificationType.error);
                      } else {
                        if (!loadingBtn) {
                          if (mounted) {
                            setState(() {
                              loadingBtn = true;
                            });
                          }
                          await Future.delayed(const Duration(seconds: 1));
                          UpdateDiary(
                                  title: titleController,
                                  diary: diaryController,
                                  id: widget.id!)
                              .updateDiaryEntry();
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
                            "UPDATE",
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
          ),
        ],
      ),
    );
  }
}
