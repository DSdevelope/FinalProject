import 'package:finalproject/utils/screens.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemTextStyle = TextStyle(fontSize: 15.sp);
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
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey[400])
                )
            ),
          ),
          ListTile(
            leading: Icon(
                Icons.settings, color: Colors.blue, size: 24.r),
            title: Text(Strings.settings, style: itemTextStyle),
            onTap: () {
              Navigator.of(context).popAndPushNamed(Screens.settings);
            },
          ),
          ListTile(
            leading: Icon(
               Icons.info_outline, color: Colors.green, size: 24.r),
            title: Text(Strings.about, style: itemTextStyle),
            onTap: () {
              Navigator.of(context).popAndPushNamed(Screens.about);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
                Icons.logout, color: Colors.orangeAccent, size: 24.r),
            title: Text(Strings.logout, style: itemTextStyle),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(Screens.auth, (route) => false);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.close, color: Colors.red, size: 24.r),
            title: Text(Strings.exit, style: itemTextStyle),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
