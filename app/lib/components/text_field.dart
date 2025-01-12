import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool? obscureText;
  final Icon? icon;
  final BoxDecoration? anim;
  final bool? activeAnim;
  final int? minLines;
  final int? maxLines;
  final TextInputType? textInputType;
  const MyTextField({super.key, this.controller, required this.hintText, this.obscureText, this.icon, this.anim, this.activeAnim, this.minLines, this.maxLines = 1, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceIn,
      decoration: anim ?? BoxDecoration(),
      
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: textInputType,
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
      ),
    );
  }
}