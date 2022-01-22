import 'package:finalproject/utils/prefkeys.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Brightness _currentTheme;
  final _storage = GetStorage();


  @override
  void initState() {
    super.initState();
    bool isDarkMode = _storage.read(PrefKeys.isDarkTheme) ?? false;
    _currentTheme = isDarkMode? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.settings)),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14.0.w),
              child: Text(Strings.theme,
                  style: TextStyle(fontSize: 15.sp, color: Colors.blue)
              ),
            ),
            SizedBox(height: 4.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Column(
                  children: [
                    RadioListTile<Brightness>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: _currentTheme,
                      value: Brightness.light,
                      title: Text(Strings.light, style: TextStyle(fontSize: 18.sp)
                      ),
                      onChanged: (value) =>
                        setState(() {
                          _storage.write(PrefKeys.isDarkTheme, false);
                          Get.changeThemeMode(ThemeMode.light);
                          _currentTheme = value!;
                        }),
                    ),
                    RadioListTile<Brightness>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: _currentTheme,
                      value: Brightness.dark,
                      title: Text(Strings.dark, style: TextStyle(fontSize: 18.sp)
                      ),
                      onChanged: (value) =>
                          setState(() {
                            _storage.write(PrefKeys.isDarkTheme, true);
                            Get.changeThemeMode(ThemeMode.dark);
                            _currentTheme = value!;
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
