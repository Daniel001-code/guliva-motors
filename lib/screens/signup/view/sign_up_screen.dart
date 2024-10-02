import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guliva_motors/controller/signin_signup_provider.dart';
import 'package:guliva_motors/core/constants.dart';
import 'package:guliva_motors/screens/login/model/login_data_model.dart';
import 'package:guliva_motors/screens/login/view/widgets/plane_text_field.dart';
import 'package:guliva_motors/screens/signup/view/widgets/sign_up_text_field.dart';
import 'package:guliva_motors/screens/vehicle_list/view/vehicle_list.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<DataModel?> signUpUser(String firstName, String lastName, String dob,
      String email, String phoneNo, String password) async {
    try {
      var response = await http.post(
          Uri.parse(
            'https://$baseURL$registerEndpoint',
          ),
          body: jsonEncode(
            {
              "firstName": firstName,
              "lastName": lastName,
              "dob": dob,
              "email": email,
              "phoneNo": phoneNo,
              "password": password
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

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = pickedDate.toString().split(" ")[0];
      });
    }
  }

  final _formkey = GlobalKey<FormState>();

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
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      Center(
                          child: Text(
                        'SIGN UP WITH EMAIL',
                        style: TextStyle(
                          color: const Color(0xFF7C7B7B),
                          fontSize: 14.sp,
                        ),
                      )),
                      SizedBox(height: 5.h),

                      // first name text field
                      SignUpTextField(
                        controller: _firstNameController,
                        title: 'First Name',
                      ),
                      SizedBox(height: 15.h),

                      // last name text field
                      SignUpTextField(
                        controller: _lastNameController,
                        title: 'Last Name',
                      ),
                      SizedBox(height: 15.h),

                      // phone number text field
                      SignUpTextField(
                        controller: _phoneNumberController,
                        title: 'Phone Number',
                      ),

                      SizedBox(height: 15.h),
                      PlaneTextField(
                        title: 'Email',
                        controller: _emailController,
                        validator: value.validateEmail,
                      ),

                      SizedBox(height: 15.h),

                      // date of birth

                      Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontSize: 13.5.sp, color: const Color(0xFF7C7D7D)),
                      ),
                      SizedBox(height: 5.h),

                      // dob form field

                      TextFormField(
                        controller: _dobController,
                        readOnly: true,
                        onTap: () => _selectDate(),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            size: 24.w,
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
                        height: 15.h,
                      ),

                      // password
                      Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 13.5.sp, color: const Color(0xFF7C7D7D)),
                      ),
                      SizedBox(height: 5.h),

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

                      Row(
                        children: [
                          SizedBox(
                            width: 22.w,
                            child: Checkbox(
                                value: value.checked,
                                onChanged: (isChecked) {
                                  setState(() {
                                    value.checked = isChecked!;
                                  });
                                }),
                          ),
                          RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  children: [
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFF031E3A)),
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFFEE8B62)),
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFF031E3A)),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFFEE8B62)),
                                ),
                              ])),
                        ],
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      // sign up button
                      ElevatedButton(
                        onPressed: value.checked
                            ? () async {
                                if (_formkey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            content: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 80.w),
                                              child:
                                                  const CircularProgressIndicator(),
                                            ),
                                          ));
                                  final result = await signUpUser(
                                      _firstNameController.text.trim(),
                                      _lastNameController.text.trim(),
                                      _dobController.text.trim(),
                                      _emailController.text.trim(),
                                      _phoneNumberController.text.trim(),
                                      _passwordController.text.trim());

                                  if (result!.success == true) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const VehicleList()));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              content:
                                                  Text('Something went wrong'),
                                            ));
                                  }
                                }
                              }
                            : null,
                        style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                              BorderSide(color: Colors.black, width: 2.w)),
                          elevation: const WidgetStatePropertyAll(0),
                          backgroundColor: WidgetStatePropertyAll(value.checked
                              ? const Color(0XFF053972)
                              : const Color(0XFF6A727F)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w)))),
                          fixedSize: WidgetStatePropertyAll(
                              Size(MediaQuery.of(context).size.width, 42.h)),
                        ),
                        child: Text(
                          'SIGN UP',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.5.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
