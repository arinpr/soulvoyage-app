import 'package:flutter/material.dart';
import 'package:soulvoyage/component/constatnt.dart';
class DefaultButton extends StatelessWidget {
  final Widget name;
  final Function() onPressed;
  const DefaultButton({
    super.key, required this.name, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        
        padding:const EdgeInsets.symmetric(vertical: 10),
      backgroundColor: kButtonColor, // Set the button color using hex value
      foregroundColor: Colors.white, // Text color
    ),
      child:  name,
    );
  }
}
