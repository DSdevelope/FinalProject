import 'package:finalproject/screens/about_screen.dart';
import 'package:finalproject/screens/auth_screen.dart';
import 'package:finalproject/screens/registration_screen.dart';
import 'package:finalproject/screens/settings_screen.dart';
import 'package:finalproject/screens/users_list_screen.dart';
import 'package:finalproject/utils/prefkeys.dart';
import 'package:finalproject/utils/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 1013.33),
      minTextAdapt: false,
      builder: () =>
          GetMaterialApp(
            title: 'Final Project',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: getThemeMode(),
            initialRoute: Screens.auth,
            routes: {
              Screens.auth: (context) => const AuthScreen(),
              Screens.registration: (context) => const RegistrationScreen(),
              Screens.users: (context) => const UsersListScreen(),
              Screens.about: (context) => const AboutScreen(),
              Screens.settings: (context) => const SettingsScreen(),
            },
          ),

    );
  }

  ThemeMode getThemeMode() {
    bool isDarkMode = GetStorage().read(PrefKeys.isDarkTheme) ?? false;
    return isDarkMode? ThemeMode.dark : ThemeMode.light;
  }
}
