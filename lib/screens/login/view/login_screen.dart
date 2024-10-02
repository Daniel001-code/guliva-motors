import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guliva_motors/controller/signin_signup_provider.dart';
import 'package:guliva_motors/core/constants.dart';
import 'package:guliva_motors/screens/login/model/login_data_model.dart';
import 'package:guliva_motors/screens/login/view/widgets/login_with_container.dart';
import 'package:guliva_motors/screens/login/view/widgets/plane_text_field.dart';
import 'package:guliva_motors/screens/vehicle_list/view/vehicle_list.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late DataModel? _dataModel;
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<DataModel?> loginUser(String email, String password) async {
    print(email + 'and' + password);
    try {
      var response = await http.post(
          Uri.parse(
            'https://$baseURL$loginEndpoint',
          ),
          body: jsonEncode(
            {
              "email": email,
              "password": password,
            },
          ),
          headers: {"Content-Type": "application/json"});

      var data = response.body;

      print(data);

      if (response.statusCode == 200) {
        print('..............Success...............');
        String responseString = response.body;
        final result = dataModelFromJson(responseString);

        return result;
      } else {
        print('...........Something went wrong..........');
        return null;
      }
    } catch (e) {
      Text(e.toString());
    }
    return null;
  }

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
      body: Consumer<SigninSignupProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),

                    // text : login
                    Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFF122847)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    // text: login with
                    Center(
                      child: Text(
                        'LOG IN WITH...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp, color: const Color(0xFF7C7D7D)),
                      ),
                    ),
                    SizedBox(height: 15.h),

                    // button: google and facebook login

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LoginWithContainer(
                          logoPath: 'assets/google_logo.png',
                          title: 'GOOGLE',
                          height: 17.h,
                          width: 17.w,
                        ),
                        LoginWithContainer(
                          logoPath: 'assets/facebook_logo.png',
                          title: 'FACEBOOK',
                          height: 23.h,
                          width: 23.w,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 25.h,
                    ),
                    // text: login with email
                    Center(
                      child: Text(
                        'LOG IN WITH EMAIL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp, color: const Color(0xFF7C7D7D)),
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    //  textfield costume widget
                    PlaneTextField(
                      title: 'Email address',
                      controller: _emailController,
                      validator: value.validateEmail,
                    ),
                    SizedBox(height: 25.h),

                    // text: password

                    Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 13.5.sp, color: const Color(0xFF7C7D7D)),
                    ),

                    // password form field

                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.remove_red_eye_outlined,
                          size: 27.w,
                          color: const Color(0xFFBCBCBC),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFBDBCBC)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.w))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFBDBCBC)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.w))),
                        // enabledBorder: InputBorder.none,
                      ),
                      validator: (input) =>
                          input!.length < 5 ? 'Invalid input' : null,
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    // text: forgot Password?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5.sp,
                            color: const Color(0xFFE96F39),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 80.w),
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ));
                          final result = await loginUser(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );

                          if (result!.success == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const VehicleList()));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      content: Text('Something went wrong'),
                                    ));
                          }
                        }
                      },
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                            BorderSide(color: Colors.black, width: 2.w)),
                        elevation: const WidgetStatePropertyAll(0),
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0XFF053972)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.w)))),
                        fixedSize: WidgetStatePropertyAll(
                            Size(MediaQuery.of(context).size.width, 42.h)),
                      ),
                      child: Text(
                        'LOG IN',
                        style:
                            TextStyle(color: Colors.white, fontSize: 12.5.sp),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // finger print
                    Center(
                      child: Image.asset(
                        'assets/finger_print.png',
                        height: 60.h,
                        width: 60.w,
                        color: const Color(0XFF003871),
                      ),
                    ),

                    // text: Touch / Face ID

                    Center(
                      child: Text(
                        'Touch / Face ID',
                        style: TextStyle(
                            color: const Color(0XFF003871),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Don't have an accoount?

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              color: const Color(0XFF003871),
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5.sp,
                              color: const Color(0xFFE96F39),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // text: Sign Up
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
