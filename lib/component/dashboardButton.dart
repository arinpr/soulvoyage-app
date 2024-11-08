import 'package:flutter/material.dart';
import 'package:soulvoyage/component/constatnt.dart';
class DashboardButton extends StatelessWidget {
  final Widget name;
  final Function() onPressed;
  const DashboardButton({
    super.key, required this.name, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set the border radius to 10
        ),
        padding:const EdgeInsets.symmetric(vertical: 10),
      backgroundColor: kButton, // Set the button color using hex value
      foregroundColor: Colors.white, // Text color
    ),
      child:  name,
    );
  }
}
