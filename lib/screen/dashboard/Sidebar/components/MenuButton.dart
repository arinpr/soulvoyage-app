import 'package:flutter/material.dart';
import 'package:soulvoyage/component/constatnt.dart';
class MenuButtons extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const MenuButtons({
    super.key, required this.title, required this.icon, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.01),
      child: Container(
        height: size.height * 0.058,
        child: ElevatedButton(
           onPressed: onPressed,
           style: ElevatedButton.styleFrom(
            
            enableFeedback: true,
            //  padding:  EdgeInsets.all(size.height * 0.01),
            //  foregroundColor: Colors.white, // Background color
            backgroundColor: Colors.white,
             // Text color when pressed
             shadowColor: kTextColor.withOpacity(0.3), // Shadow color
             elevation: 5, // Elevation to give the button a shadow effect
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners
              side:  BorderSide( // Add a 1px border
                color: kTextColor.withOpacity(0.05), // Border color
                width: 1, // Border width
              ),
            ),
          
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children:  [
                 SizedBox(width: size.width * 0.001),
               Icon(icon, size: size.width * 0.06, color: Colors.black87),
               const SizedBox(width: 20),
               Text(
                 title,
                 style:const TextStyle(
                   color: kTextColor, 
                   fontSize: 20, 
                   fontWeight: FontWeight.w400,
                 ),
               ),
             ],
           ),
         ),
      ),
    );
  }
}