import 'package:flutter/widgets.dart';

class SigninSignupProvider extends ChangeNotifier {
  bool checked = false;

  String? validateEmail(String? email) {
    RegExp emailRejex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRejex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
