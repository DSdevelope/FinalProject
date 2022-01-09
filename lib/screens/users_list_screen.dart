import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.users),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.separated(
          itemCount: 20,
          separatorBuilder: (context, _) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Name'),
            );
          },
        ),
      ),
    );
  }
}
