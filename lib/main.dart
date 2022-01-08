import 'package:finalproject/utils/screens.dart';
import 'package:finalproject/screens/about_screen.dart';
import 'package:finalproject/screens/auth_screen.dart';
import 'package:finalproject/screens/settings_screen.dart';
import 'package:finalproject/screens/users_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: Screens.auth,
      routes: {
        Screens.auth: (context) => const AuthScreen(),
        Screens.users: (context) => const UsersListScreen(),
        Screens.about: (context) => const AboutScreen(),
        Screens.settings: (context) => const SettingsScreen(),
      },
    );
  }
}
