import 'dart:convert';

import 'package:finalproject/models/user.dart';
import 'package:finalproject/screens/user_detail_screen.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:finalproject/widgets/app_drawer.dart';
import 'package:finalproject/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late Future<List<User>> _usersList;


  @override
  void initState() {
    super.initState();
    _usersList = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.users),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: FutureBuilder<List<User>>(
          future: _usersList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Please, check internet connection. Error! ${snapshot.error}')
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, _) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return UserListTile(
                  id: user.id,
                  email: user.email,
                  name: user.name,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailScreen(user: user),
                        ));
                  },
                );
              },
            );
          }
        ),
      ),
    );
  }
}

Future<List<User>> fetchUsers() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    var jsonList = jsonDecode(response.body) as List;
    List<User> list = jsonList.map((data) => User.fromJson(data)).toList();

    return list;
  } else {
    throw Exception('Failed to load users');
  }
}


