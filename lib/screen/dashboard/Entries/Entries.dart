import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
  import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // For formatting date
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:soulvoyage/screen/dashboard/EditScreen/EditScreen.dart';
import 'package:soulvoyage/screen/dashboard/Entries/openEntries/OpenEntries.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/Sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

class Entries extends StatefulWidget {
  const Entries({super.key});

  @override
  State<Entries> createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  DateTime? backPressTime;
  bool isListSelected = true;

  List<Map<String, dynamic>> diaryEntries = [];
  bool isLoading = true; // Flag to indicate loading

  // API fetching method
  Future<void> fetchDiaryEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final url = Uri.parse("$allEntries/$email");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          diaryEntries = List<Map<String, dynamic>>.from(data.map((entry) => {
                "id": entry["id"],
                "title": entry["title"],
                "journalEntry": entry["journalEntry"],
                "modifiedDate": entry["modifiedDate"],
                "emotionAttached": entry["emotionAttached"]
              }));
          isLoading = false; // Stop loading
        });
      } else {
       
        showCustomToast(title: 'Failed to fetch data', type: ToastificationType.error);
        
      }
    } catch (e) {
      showCustomToast(title: 'Error occurred: $e', type: ToastificationType.error);
      
    }
  }

  // Delete API method
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
      if (response.statusCode == 200) {
         showCustomToast(title: 'Entry deleted successfully', type: ToastificationType.success);
        
        fetchDiaryEntries(); // Refresh the list after deletion
      } else {
         showCustomToast(title: 'Failed to delete entry: ${response.statusCode}', type: ToastificationType.error);
        
      }
    } catch (e) {
      showCustomToast(title: 'An error occurred: $e', type: ToastificationType.error);
      
    }
  }

  void showDeleteConfirmationDialog(id) {
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
        deleteEntry(id);
      },
      btnOkText: "Delete",
      btnCancelText: "Cancel",
      btnOkColor: Colors.red,
    ).show();
  }

  // Emotion map
  Map<String, String> emotionMap = {
    "1": "😞",
    "2": "😐",
    "3": "🙂",
    "4": "😃",
    "5": "😊",
  };

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) > const Duration(seconds: 2)) {
      backPressTime = now;
      Fluttertoast.showToast(
        msg: "Press again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    fetchDiaryEntries(); // Fetch data on initialization
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 35,
            highlightColor: const Color.fromARGB(255, 199, 217, 234),
            onPressed: () {
              Get.to(() => const Sidebar(),
              transition: Transition.leftToRight,
              );
            },
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset('assets/Images/menu.svg'),
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
        backgroundColor: kPageColor,
        body: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  // border: Border(
                  //   bottom: BorderSide(
                  //     color: kBorderColor, // Border color
                  //     width: 1.0, // Border thickness
                  //   ),
                  // ),
                  // color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //       offset: Offset(2, 2),
                  //       blurRadius: 10,
                  //       spreadRadius: 2,
                  //       color: Colors.black12)
                  // ]
                  ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    //by default is List View
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // List Tab Button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isListSelected = true;
                              });
                              // Add your "List" button functionality here
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: isListSelected
                                    ? Colors.blue
                                    : Colors.white, // Active color
                                // shape: BoxShape.circle,
                                border: Border.all(color: Colors.blueAccent, width: 1),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.list,
                                  color: !isListSelected? kTextColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Spacing between buttons

                          // Grid Tab Button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isListSelected = false;
                              });
                              // Add your "Grid" button functionality here
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: !isListSelected
                                    ? Colors.blue
                                    : Colors.white, // Active color
                                // shape: BoxShape.circle,
                                border: Border.all(color: Colors.blue, width: 2),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.grid_view_outlined,
                                  color: isListSelected? kTextColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: isLoading
                        ? _buildShimmerEffect() // Display shimmer effect while loading
                        : Column(
                            children: diaryEntries.map((entry) {
                              //total entries
                              return isListSelected? _buildDiaryEntryList(entry): _buildDiaryEntryGrid(entry);
                            }).toList(),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build shimmer effect
  Widget _buildShimmerEffect() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(4, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: size.height * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }

  // Method to build each diary entry container
  Widget _buildDiaryEntryList(Map<String, dynamic> entry) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // height: size.height * 0.17,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black12,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Title, Subtitle, and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow
                        .ellipsis, // Title will be truncated with ...
                  ),
                  // const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      entry['journalEntry'],
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis, // Subtitle truncated with ...
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(emotionMap[entry['emotionAttached']] ?? ""),
                      const SizedBox(width: 10,),
                      Text(
                        _formatDate(entry['modifiedDate']),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Right side: Emotion, Open button, and 3-dot menu
            
            ElevatedButton(
                        onPressed: () {
                          Get.to(() => Openentries(
                                title: entry['title'],
                                subTitle: entry['journalEntry'],
                                emotionAttached: entry['emotionAttached'],
                                id: entry['id'],
                              ),
                              transition: Transition.noTransition,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(
                              80, 30), // Set the minimum width and height
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5), // Smaller padding
                          textStyle: const TextStyle(
                              fontSize: 14), // Smaller font size
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Border radius of 10
                          ),
                        ),
                        child: const Text('Open'),
                      ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  Get.to(() => EditDiaryScreen(
                        id: entry['id'],
                        title: entry['title'],
                        journalEntry: entry['journalEntry'],
                      ));
                } else if (value == 'delete') {
                  showDeleteConfirmationDialog(
                      entry['id']); // Call delete method
                  // print(entry['id']);
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildDiaryEntryGrid(Map<String, dynamic> entry) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // height: size.height * 0.17,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black12,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Title, Subtitle, and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis, // Title will be truncated with ...
                        ),
                        
                      ),
                      Text(emotionMap[entry['emotionAttached']] ?? ""),
                      const SizedBox(width: 5,),
                      //date will be here

                      Text(
                        _formatDate(entry['modifiedDate']),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      entry['journalEntry'],
                      maxLines: 5,
                      overflow:
                          TextOverflow.ellipsis, // Subtitle truncated with ...
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => EditDiaryScreen(
                                    id: entry['id'],
                                    title: entry['title'],
                                    journalEntry: entry['journalEntry'],
                                  ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kTextColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(
                                    80, 30), // Set the minimum width and height
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5), // Smaller padding
                                textStyle: const TextStyle(
                                    fontSize: 14), // Smaller font size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Border radius of 10
                                ),
                              ),
                              child: const Text('Edit'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //delete button

                            ElevatedButton(
                              onPressed: () {
                                showDeleteConfirmationDialog(entry['id']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(
                                    80, 30), // Set the minimum width and height
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5), // Smaller padding
                                textStyle: const TextStyle(
                                    fontSize: 14), // Smaller font size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Border radius of 10
                                ),
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ),

                      // open button
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => Openentries(
                                title: entry['title'],
                                subTitle: entry['journalEntry'],
                                emotionAttached: entry['emotionAttached'],
                                id: entry['id'],
                              ),transition: Transition.noTransition,);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(
                              80, 30), // Set the minimum width and height
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5), // Smaller padding
                          textStyle: const TextStyle(
                              fontSize: 14), // Smaller font size
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Border radius of 10
                          ),
                        ),
                        child: const Text('Open'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Right side: Emotion, Open button, and 3-dot menu
          ],
        ),
      ),
    );
  }

  // Helper method to format date
  String _formatDate(String isoDate) {
    final DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }
}
