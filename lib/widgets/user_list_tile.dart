import 'package:flutter/material.dart';

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
        radius: 22,
        backgroundColor: Colors.blueGrey[400],
        child: Text(
          id.toString(),
          style: const TextStyle(
              fontSize: 22,
              color: Colors.white
          ),
        ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(email,),
    );
  }
}
