import 'dart:developer';

import 'package:finalproject/utils/prefkeys.dart';
import 'package:finalproject/utils/screens.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(36.r)),
    borderSide: BorderSide(
        color: Colors.transparent, width: 2.w)
);
final TextStyle linkTextStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  color: Colors.blue[700],
);

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  final _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.light),
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/beach.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 55.h,),
                  SizedBox(
                    height: 250.h,
                    child: const Image(
                      image: AssetImage('assets/welcome.png'),
                      color: Colors.white70,),
                  ),
                  SizedBox(height: 50.h,),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: TextStyle(fontSize: 17.sp,),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: Strings.phone,
                      prefixText: Strings.phonePrefix,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 18.h),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: 17.sp,),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: Strings.password6symbols,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 18.h),
                    ),
                  ),
                  SizedBox(height: 45.h,),
                  TextField(
                    controller: _confirmController,
                    obscureText: true,
                    style: TextStyle(fontSize: 17.sp,),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: Strings.confirmPassword,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 18.h),
                    ),
                  ),
                  SizedBox(height: 55.h,),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_verifyInputData(context)) {
                          verifyPhone(_phoneController.text);
                          // saveUserData();
                          // Navigator.of(context).popAndPushNamed(Screens.users);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                        child: Text(
                            Strings.register,
                            style: TextStyle(fontSize: 22.sp)
                          ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0079D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 52.h,),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(36.0.r),
                      ),
                      child: Text(Strings.loginToAccount, style: linkTextStyle,)
                    ),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(Screens.auth);
                    }
                    ),
                  SizedBox(height: 40.h,),
                ],
              ),
            ),
          ),
      ),
    );
  }

  bool _verifyInputData(BuildContext context) {
    if (_phoneController.text.length < 10) {
      _showSnackBar(context, Strings.phoneLengthIncorrect);
      return false;
    }
    if (_phoneController.text == _storage.read(PrefKeys.phoneNumber)) {
      _showSnackBar(context, Strings.userAlreadyRegistered);
      return false;
    }
    if (_passwordController.text.length < 6) {
      _showSnackBar(context, Strings.passwordLengthIncorrect);
      return false;
    }
    if (_confirmController.text.isEmpty) {
      _showSnackBar(context, Strings.confirmPassword);
      return false;
    }
    if (_confirmController.text != _passwordController.text) {
      _showSnackBar(context, Strings.confirmIncorrect);
      return false;
    }
    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        )
    );
  }

  void verifyPhone(String phone) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // TODO Вывести диалог об ошибке
        log('Phone verification error: ${e.code}');
      },
      codeSent: (String verificationId, int? resendToken) {

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void saveUserData() {
    _storage.write(PrefKeys.phoneNumber, _phoneController.text);
    _storage.write(PrefKeys.password, _passwordController.text);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

}
