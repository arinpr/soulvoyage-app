import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/Sidebar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
    DateTime? backPressTime;

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
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
            backgroundColor: kPageColor,
          ),
          backgroundColor: kPageColor,
          body:SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05,),
            Center(child: Image.asset('assets/Images/about.png')),
            SizedBox(height: size.height * 0.03,),
            Text('About us', style: TextStyle(fontSize: size.width * 0.09, fontWeight: FontWeight.bold),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.02),
      
              height: 1,width: double.infinity,color: kButtonColor,),
            Text('The Possibilities Are Beyond Your Imagination',textAlign: TextAlign.center, style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.w500),),
            AboutCard(
              title: "Personalized Insights",
              text: "AI algorithms can detect and analyze emotions expressed in your journal entries. This feature can help track mood patterns, identify triggers for emotional highs or lows, and offer suggestions for coping mechanisms or interventions.",
              icon: Image.asset('assets/Images/gr/pic1.png'),
            ),
            AboutCard(
              title: "Therapeutics",
              text: "This AI-based journaling tools is integrated with mental health or wellness apps, providing users with guidance, exercises, or interventions based on their journal content.",
              icon: Image.asset('assets/Images/gr/pic2.png'),
            ),
            AboutCard(
              title: "Motivational Stories",
              text: "Depending upon your mood, this AI based journal will show to motivational stories to help you keep a positive mindset.",
              icon: Image.asset('assets/Images/gr/pic3.png'),
            ),
            AboutCard(
              title: "Privacy and Security",
              text: "This tool ensures the privacy and security of your journal entries through encryption, secure storage, or even personalized access controls.",
              icon: Image.asset('assets/Images/gr/pic4.png'),
            ),
            AboutCard(
              title: "Entry Suggestions",
              text: "This AI-powered journaling platform can analyze your previous entries and suggest topics or prompts for your next journal entry. This is based on sentiment analysis, recurring themes, or keywords in your writing.",
              icon: Image.asset('assets/Images/gr/pic5.png'),
            ),
            AboutCard(
              title: "Smart Search",
              text: "This platform can categorize entries, making it easier to search for specific topics or themes.",
              icon: Image.asset('assets/Images/gr/pic6.png'),
            ),
            const SizedBox(height: 50,),
          ],
        )),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {

final String title;
final String text;
final Image icon;

  const AboutCard({
    super.key, required this.title, required this.text, required this.icon,
   
  });

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.04), 
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 10),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      
      ), 
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // Image.asset('assets/Images/aboutus.png', scale: 0.7,),
              icon,
              const SizedBox(width: 10,),
               Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            ],
          ),
          SizedBox(height: size.height * 0.03,),
          Text(text),
          SizedBox(height: size.height * 0.03,),
        ],
      ),
      );
  }
}