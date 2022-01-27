import 'package:finalproject/screens/registration_screen.dart';
import 'package:finalproject/utils/prefkeys.dart';
import 'package:finalproject/utils/screens.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  final _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.light),
      child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bc_bg.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 70.h,),
                  SizedBox(
                    width: 250.w,
                    height: 250.h,
                    child: const Image(image: AssetImage('assets/logo.png')),
                  ),
                  SizedBox(height: 65.h,),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: Strings.password,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 18.h),
                    ),
                  ),
                  SizedBox(height: 55.h,),
                  SizedBox(
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_verifyInputData(context)) {
                          Navigator.of(context).popAndPushNamed(Screens.users);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Text(
                            Strings.login,
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
                    child: Text(Strings.registration, style: linkTextStyle,),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(Screens.registration);
                    }
                  ),
                  SizedBox(height: 40.h,),
                  InkWell(
                    child: Text(Strings.forgotPassword, style: linkTextStyle,),
                    onTap: () {
                      showResetPasswordDialog(context);
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
    String phoneNumber = _storage.read(PrefKeys.phoneNumber) ?? Strings.phoneNumberDefault;
    if (_phoneController.text != phoneNumber) {
      _showSnackBar(context, Strings.phoneIncorrect);
      return false;
    }

    if (_passwordController.text.length < 6) {
      _showSnackBar(context, Strings.passwordLengthIncorrect);
      return false;
    }
    String password = _storage.read(PrefKeys.password) ?? Strings.passwordDefault;
    if (_passwordController.text != password) {
      _showSnackBar(context, Strings.passwordIncorrect);
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

  Future<void> showResetPasswordDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(Strings.alertResetTitle),
            content: const Text(Strings.alertResetBody),
            actions: <Widget>[
              TextButton(
                child: const Text('НЕТ', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('ДА', style: TextStyle(color: Colors.green)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(Strings.passwordResets),
                      )
                  );
                  _storage.remove(PrefKeys.phoneNumber);
                  _storage.remove(PrefKeys.password);
                  Navigator.of(context).pushNamedAndRemoveUntil(Screens.registration, (route) => false);
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
