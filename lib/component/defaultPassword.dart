import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final String? errorText;
  final String? labelText;
  final TextEditingController controller;
  
  const PasswordInputField({
    super.key,
    this.labelText,
    required this.controller, required this.errorText,
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true; // Initially obscure the text

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 8),
        //   child: Text("${widget.labelText}:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        // ),
        SizedBox(height: size.height * 0.01,),
        SizedBox(
          height: size.height * 0.08,
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText, // Toggle password visibility
            decoration: InputDecoration(
              errorText: widget.errorText,
              labelText: widget.labelText,
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
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle the visibility state
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
