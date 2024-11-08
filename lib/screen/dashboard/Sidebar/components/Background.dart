import 'package:flutter/material.dart';
import 'package:soulvoyage/component/constatnt.dart';

class Background extends StatelessWidget {
  final Widget header;
  final Widget menuItem;
  final Widget logoutButton;
  const Background({super.key, required this.header, required this.menuItem, required this.logoutButton});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Stack(
        children: [
          // Black background at the top
          Container(
            height: size.height * 0.25,
            width: double.infinity,
            color: kTextColor,
          ),
          // White container with margin and shadow
          Positioned(
            top: size.height * 0.25,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              height: size.height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: kBorderColor),
                boxShadow: const [
                  BoxShadow(
                    color: kBorderColor,
                    offset: Offset(0, 6),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: menuItem,
            ),
          ),
          // Child (e.g. Text) on top of other widgets
          Positioned(
            top: 0, // Adjust the position to suit your design
            left: 0,
            right: 0,
            child: header, // Your custom child widget, now on top
          ),
          // Elevated Button at the bottom of the screen
          Positioned(
            bottom: 20.0, // 20px from the bottom
            left: 20.0, // 20px from the left side
            right: 20.0, // 20px from the right side
            child: logoutButton,
          ),
        ],
      ),
    );
  }
}
