import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soulvoyage/component/toast.dart';
import 'package:soulvoyage/screen/dashboard/EditScreen/EditScreen.dart';
import 'package:soulvoyage/screen/dashboard/Entries/Entries.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:toastification/toastification.dart';

class Openentries extends StatefulWidget {
  final String title;
  final String subTitle;
  final String emotionAttached;
  final String id;
  const Openentries(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.emotionAttached,
      required this.id});

  @override
  State<Openentries> createState() => _OpenentriesState();
}

class _OpenentriesState extends State<Openentries> {
  Future<void> deleteEntry(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwttoken');
    final url = Uri.parse('$deleteEntries/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': '$token', // Pass the Bearer token
          'Content-Type': 'application/json', // Ensure JSON content type
        },
      );
      Get.offAll(() => const Entries());
      if (response.statusCode == 200) {
       
         showCustomToast(title: 'Entry deleted successfully', type: ToastificationType.success);
         
        
      } else {
        showCustomToast(title: 'Failed to delete entry: ${response.statusCode}', type: ToastificationType.error);
        
       
      }
    } catch (e) {
       showCustomToast(title: 'An error occurred: $e', type: ToastificationType.error);
      
    }
  }

  void showDeleteConfirmationDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      title: 'Confirm Delete',
      desc: 'Are you sure you want to delete this entry?',
      btnCancelOnPress: () {},
      btnCancelColor: kTextColor,
      btnOkOnPress: () {
        deleteEntry(widget.id);
      },
      btnOkText: "Delete",
      btnCancelText: "Cancel",
      btnOkColor: Colors.red,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
              onPressed: () {
                FocusScope.of(context).unfocus();
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
              SizedBox(width: size.width * 0.07,),
              Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:const DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
              const SizedBox(width: 20,),
               const Text(
                'SoulVoyage',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kTextColor),
              ),
            ],
          ),
        centerTitle: true,
        backgroundColor: kPageColor, // Customize your app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: kTextColor),
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.black12),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: kTextColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(widget.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            height: 20,
                            width: 20,
                            child: const Text("😐"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: size.height * 0.7,
                    child: SingleChildScrollView(
                        child: Text(
                          textAlign: TextAlign.start,
                      widget.subTitle,
                      style: const TextStyle(
                          fontSize: 15,
                          color: kTextColor,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => EditDiaryScreen(
                            id: widget.id,
                            title: widget.title,
                            journalEntry: widget.subTitle,
                          ), transition: Transition.noTransition);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set border radius to 10
                            ),
                          ),
                          child: const Text("Edit"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(); // Show confirmation dialog
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set border radius to 10
                            ),
                          ),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
