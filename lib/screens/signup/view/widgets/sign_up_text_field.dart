import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    super.key,
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.5.sp, color: const Color(0xFF7C7D7D)),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFBDBCBC)),
                borderRadius: BorderRadius.all(Radius.circular(5.w))),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFBDBCBC)),
                borderRadius: BorderRadius.all(Radius.circular(5.w))),
            // enabledBorder: InputBorder.none,
          ),
          validator: (input) => input!.length < 5 ? 'Invalid input' : null,
        ),
      ],
    );
  }
}
