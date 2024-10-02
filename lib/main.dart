import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guliva_motors/controller/signin_signup_provider.dart';
import 'package:guliva_motors/screens/login/view/login_screen.dart';
import 'package:guliva_motors/screens/signup/view/sign_up_screen.dart';
import 'package:guliva_motors/screens/vehicle_list/view/vehicle_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SigninSignupProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Guliva-motors',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: child,
        routes: {
          'signup': (context) => const SignUpScreen(),
          '/': (context) => const LoginScreen(),
          'vehicleList': (context) => const VehicleList(),
        },
        initialRoute: '/',
      ),
    );
  }
}
