import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: const DecorationImage(
                image: AssetImage('assets/avatar_drawer.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(Strings.phoneNumberDefault,
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey)
                )
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(Strings.settings),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.green),
            title: const Text(Strings.about),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/about');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.orangeAccent),
            title: const Text(Strings.logout),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.close, color: Colors.red),
            title: const Text(Strings.exit),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
