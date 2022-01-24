import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.about)),
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(30.r),
            child: Text(
              Strings.aboutText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp)),
          ),
        ),
      ),
    );
  }
}
