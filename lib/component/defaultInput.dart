import 'package:flutter/material.dart';


class DefaultInputField extends StatelessWidget {
  final String? errorText;
  final String? labelText;
  final TextEditingController controller;
  const DefaultInputField({
    super.key,  this.labelText, required this.controller, required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return  Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 8),
        //   child: Text("$labelText :", style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        // ),
         SizedBox(height: size.height * 0.01,),
        SizedBox(
          height: size.height * 0.08,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              errorText: errorText,
              labelText: labelText,
              // floatingLabelBehavior: FloatingLabelBehavior.never,
             
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Define your default border color here
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue), // Define your focused border color here
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Keep the error border the same as enabled
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue), // Keep the error border same as focused
              ),
            ),
          ),
        ),
      ],
    );
  }
}