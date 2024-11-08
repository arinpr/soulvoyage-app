import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/screen/dashboard/AboutUsScreen/About.dart';
import 'package:soulvoyage/screen/dashboard/ContactUsScreen/ContactUsScreen.dart';
import 'package:soulvoyage/screen/dashboard/Dashboard.dart';
import 'package:soulvoyage/screen/dashboard/Entries/Entries.dart';

import 'package:soulvoyage/screen/dashboard/Sidebar/components/Background.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/components/MenuButton.dart';
import 'package:soulvoyage/screen/dashboard/pricing/Pricing.dart';
import 'package:soulvoyage/screen/login.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String userName = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString("userName")!;
      email = pref.getString("email")!;
    });
  }
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Background(
      header: Column(
        children: [
          const SizedBox(height: 15,),
            Row(
              children: [
                ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), // Makes the button circular
                  padding: const EdgeInsets.all(12), // Adjusts the padding inside the button
                  backgroundColor: Colors.black,// Icon color when pressed
                  elevation: 5, // Elevation for shadow
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new, 
                    color: Colors.white, // Icon color
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: size.width * 0.2),
                child: const Text("SoulVoyage", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
              )
              ],
            ),
           SizedBox(height: size.height * 0.05,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25),
             child: Row(
              children: [
                Container(
                    height: 80,
                    width: 80,
                    // color: Colors.white,
                    child: Image.asset(
                      'assets/Images/pf.png', // Replace with your image path
                      fit: BoxFit.cover, // Ensures the image covers the container
                    ),
                  ),
                const SizedBox(width: 20,),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userName, style:const TextStyle(fontSize: 22, color: Colors.white70,fontWeight: FontWeight.bold),),
                    Text(email, style:const TextStyle(color: Colors.white70),)
                  ],
                )
              ],
              ),
           )  
        ],
      ),
      menuItem:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             MenuButtons(
              icon: Icons.home_work_outlined,
              onPressed: (){
                  Get.offAll(()=> const Dashboard(), transition: Transition.rightToLeft);
              },
              title: "Home",
              ),
              
              MenuButtons(
              icon: Icons.person_add_alt_1_outlined,
              onPressed: (){
                Get.offAll(()=> const Entries(), transition: Transition.rightToLeft);
              },
              title: "Entries",
              ),
            
               
              MenuButtons(
              icon: Icons.price_change_outlined,
              onPressed: (){
                  Get.offAll(()=>const Pricing(),transition: Transition.rightToLeft);
              },
              title: "Price",
              ),
              
              MenuButtons(
              icon: Icons.info_outline,
              onPressed: (){
                Get.offAll(()=>const About(),transition: Transition.rightToLeft);
              },
              title: "About Us",
              ),
               
              MenuButtons(
              icon: Icons.phone_callback,
              onPressed: (){
                Get.offAll(()=>const Contactusscreen(),transition: Transition.rightToLeft);
              },
              title: "Contact Us",
              ),
              
        
          ],
        ),
      ),
            logoutButton: ElevatedButton(
              onPressed: () async{
                 SharedPreferences pref = await SharedPreferences.getInstance();
                 await pref.clear();
                 Get.offAll(()=> const LoginScreenWithBackExit());
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: kTextColor, // Customize the button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              child: const Text(
                "Sign Out",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
    );
  }
}


