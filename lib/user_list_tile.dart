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
        radius: 24,
        backgroundColor: Colors.blueGrey[300],
        child: Text(
          id.toString(),
          style: const TextStyle(
              fontSize: 30,
              color: Colors.white
          ),
        ),
      ),
      title: Text(name, style: Theme.of(context).textTheme.headline6),
      subtitle: Text(email,),
    );
  }
}
