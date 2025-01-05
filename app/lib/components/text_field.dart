import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  const MyTextField({super.key, required this.hintText, required this.obscureText, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(15),
        hintText: hintText,
        suffixIcon: icon != null ? SizedBox(
          width: 50,
          child: IntrinsicHeight(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                VerticalDivider(
                  color: Colors.black,
                  indent: 5,
                  endIndent: 5,
                  thickness: 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: icon,
                )
            ],),
          ),
        )
        : null,
      ),
    );
  }
}