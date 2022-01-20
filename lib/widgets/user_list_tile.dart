import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListTile extends StatelessWidget {
  final int id;
  final String name, email;
  final Function onTap;

  const UserListTile(
      {Key? key,
      required this.id,
      required this.name,
      required this.email,
      required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {onTap();},
      leading: CircleAvatar(
        radius: 24.r,
        backgroundColor: Colors.blueGrey[300],
        child: Text(
          id.toString(),
          style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white
          ),
        ),
      ),
      title: Text(name, style: Theme.of(context).textTheme.headline6),
      subtitle: Text(email,),
    );
  }
}
