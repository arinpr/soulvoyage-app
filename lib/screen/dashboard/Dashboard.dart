import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/screen/dashboard/BlankDiaryScreen/BlankDiaryScreen.dart';
import 'package:soulvoyage/screen/dashboard/GriefJournalingScreen/GriefJournalingScreen.dart';
import 'package:soulvoyage/screen/dashboard/SafeSpaceScreen/SafeSpaceScreen.dart';
import 'package:soulvoyage/screen/dashboard/Sidebar/Sidebar.dart';
import 'package:soulvoyage/screen/dashboard/SlowMovementScreen/SlowMovementScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  DateTime? backPressTime;

  final List<Widget> _pages = [
    const BlankDiaryScreen(),
    const SafeSpaceScreen(),
    const SlowMovementScreen(),
    const GriefJournalingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (backPressTime == null || now.difference(backPressTime!) > const Duration(seconds: 2)) {
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
              child: _pages[_selectedIndex],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: kTextColor,
            selectedItemColor: kOrange,
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Blank Diary',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.safety_check),
                label: 'Safe Space',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.run_circle_outlined),
                label: 'Slow Movement',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_sharp),
                label: 'Grief Journaling',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
