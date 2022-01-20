import 'package:finalproject/screens/about_screen.dart';
import 'package:finalproject/screens/auth_screen.dart';
import 'package:finalproject/screens/settings_screen.dart';
import 'package:finalproject/screens/users_list_screen.dart';
import 'package:finalproject/utils/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 1013.33),
      minTextAdapt: true,
      builder: () =>
          MaterialApp(
            title: 'Final Project',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: Screens.users,
            routes: {
              Screens.auth: (context) => const AuthScreen(),
              Screens.users: (context) => const UsersListScreen(),
              Screens.about: (context) => const AboutScreen(),
              Screens.settings: (context) => const SettingsScreen(),
            },
          ),

    );
  }
}
