import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/component/dashboardButton.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/Sidebar.dart'; 
import 'package:flutter_svg/flutter_svg.dart';

class Contactusscreen extends StatefulWidget {
  const Contactusscreen({super.key});

  @override
  State<Contactusscreen> createState() => _ContactusscreenState();
}

class _ContactusscreenState extends State<Contactusscreen> {
  DateTime? backPressTime;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

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

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: const Text("Coming Soon"),
          content: const Text("This is under development."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: kTextColor, // Set background color
                 shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Set border radius
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.white, // Set text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        
        backgroundColor: kPageColor,
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 60,
              leading: IconButton(
                iconSize: 35,
                highlightColor: const Color.fromARGB(255, 199, 217, 234),
                onPressed: () {
                  Get.to(
                    () => const Sidebar(),
                    transition: Transition.leftToRight,
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset('assets/Images/menu.svg'),
                ),
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
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
                  const SizedBox(width: 20),
                  const Text(
                    'SoulVoyage',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kTextColor),
                  ),
                ],
              ),
              backgroundColor: kPageColor,
              centerTitle: true,
            ),
            
            SliverFillRemaining(
              child: Container(
                // height: size.height * 0.7,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const[
                    BoxShadow(offset: Offset(0, 10), blurRadius: 3, spreadRadius: 5, color: Colors.black12)
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                         Icon(Icons.mail, size: 30,),
                         SizedBox(width: 20,),
                         Text('Contact us', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TextField(
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        controller: _messageController,
                        maxLines: null, // Make TextField flexible in height
                                      expands:true, // Allows the TextField to take all available space
                                      keyboardType: TextInputType.multiline,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                        
                      ),
                    ),
                    const SizedBox(height: 24),
              Container(width: double.infinity,  child: DashboardButton(
                name:const Text(
                        "SUBMIT",
                        style: TextStyle(fontSize: 22),
                      ), 
                onPressed: _showComingSoonDialog,))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
