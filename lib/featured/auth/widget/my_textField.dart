import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatelessWidget {
  MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.visibleText,
    this.maxLine = 1,
    this.padding = const EdgeInsets.all(12),
  });
  TextEditingController? controller;
  String? hintText;
  bool visibleText;
  EdgeInsetsGeometry? padding;
  int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Correct Value';
            }
            return null;
          },
          controller: controller,
          maxLines: maxLine,
          obscureText: visibleText,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
