import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaneTextField extends StatelessWidget {
  const PlaneTextField(
      {super.key,
      required this.title,
      required this.controller,
      required this.validator});
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.5.sp, color: const Color(0xFF7C7D7D)),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFBDBCBC)),
                borderRadius: BorderRadius.all(Radius.circular(5.w))),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFBDBCBC)),
                borderRadius: BorderRadius.all(Radius.circular(5.w))),
          ),
        ),
      ],
    );
  }
}
