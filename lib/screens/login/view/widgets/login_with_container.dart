import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWithContainer extends StatelessWidget {
  const LoginWithContainer(
      {super.key,
      required this.logoPath,
      required this.title,
      required this.height,
      required this.width});
  final String logoPath;
  final String title;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 150.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.w)),
          border: Border.all(
              width: 1.w,
              style: BorderStyle.solid,
              color: const Color(0XFF053972))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            logoPath,
            color: const Color(0XFF053972),
            height: height,
            width: width,
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: const Color(0XFF053972)),
          ),
        ],
      ),
    );
  }
}
