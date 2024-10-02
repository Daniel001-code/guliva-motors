import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFCFCFC),
        centerTitle: true,

        // logo
        title: Container(
          margin: EdgeInsets.only(top: 20.h),
          height: 30.h,
          width: 86.w,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/guliva_header.png'),
                  fit: BoxFit.fill)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Development in progress'),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(
                      BorderSide(color: Colors.black, width: 2.w)),
                  elevation: const WidgetStatePropertyAll(0),
                  backgroundColor:
                      const WidgetStatePropertyAll(Color(0XFF053972)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.w)))),
                  fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.of(context).size.width, 42.h)),
                ),
                child: const Text(
                  'ADD VEHICLE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
