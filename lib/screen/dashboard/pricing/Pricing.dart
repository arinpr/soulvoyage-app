import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/Sidebar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pricing extends StatefulWidget {
  const Pricing({super.key});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
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
    return WillPopScope(
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                      vertical: size.height * 0.02),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kTextColor,
                      side: const BorderSide(width: 1, color: kTextColor),
                      shadowColor: kTextColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Pricing",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              const PriceBox(
                packageName: 'Basic',
                price: 'Free',
                items: [
                  'Journal',
                  'Journal analysis and emotion tracker',
                  'Smart search',
                ],
              ),
              // const SizedBox(height: 20),
              const PriceBox(
                packageName: 'Monthly',
                price: '\$9.99',
                items: [
                  'All in free plan',
                  'Psychologist recommendation based on journals',
                  'Mindset and emotional state analysis',
                  'Personalized feedback and suggestions',
                  'Motivational stories',
                ],
              ),
              //  const SizedBox(height: 20),
              const PriceBox(
                packageName: 'Annual',
                price: '\$80',
                items: [
                  'All in free plan',
                  'Psychologist recommendation based on journals',
                  'Mindset and emotional state analysis',
                  'Personalized feedback and suggestions',
                  'Motivational stories',
                ],
              ),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}

class PriceBox extends StatelessWidget {
  final String packageName;
  final String price;
  final List<String> items;

  const PriceBox({
    super.key,
    required this.packageName,
    required this.price,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      // height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                packageName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                price,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Container(
            height: 2,
            color: kBorderColor,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          // Generate ListItems dynamically based on the items list
          Column(
            children: items.map((item) => ListItem(itemname: item)).toList(),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String itemname;

  const ListItem({
    super.key,
    required this.itemname,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: kTextColor),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              itemname,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
