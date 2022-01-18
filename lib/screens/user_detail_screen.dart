import 'dart:convert';

import 'package:finalproject/models/user.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:finalproject/widgets/user_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/todo.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({Key? key, required this.user}) : super(key: key);
  late Future<List<Todo>> _todoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 410,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/avatar.png'))),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 60,
                        left: 4,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back, color: Colors.white))
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text(user.name,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text('(${user.username})',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white60,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                UserInfoTile(
                  title: Strings.email,
                  body: user.email,
                icon: Icons.email),
                const Divider(thickness: 1),
                UserInfoTile(
                    title: Strings.phoneEng,
                    body: user.phone,
                    icon: Icons.phone),
                const Divider(thickness: 1),
                UserInfoTile(
                    title: Strings.website,
                    body: user.website,
                    icon: Icons.web),
                const Divider(thickness: 1),
                InkWell(
                  onTap: () => showCompanyInfoDialog(context),
                  child: UserInfoTile(
                      title: Strings.company,
                      body: user.company.name,
                      icon: Icons.work),
                ),
                const Divider(thickness: 1),
                UserInfoTile(
                    title: Strings.address,
                    body: '${user.address.street}, '
                        '${user.address.suite}, '
                        '${user.address.city}, '
                        '${user.address.zipcode}',
                    icon: Icons.location_on),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    onPressed: () {
                      _todoList = fetchTodos(user.id);
                      showTodosBottomSheet(context);
                      },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: const [
                          Text(Strings.todos, style: TextStyle(fontSize: 20)
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
    );
  }

  Future<List<Todo>> fetchTodos(int userId) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=$userId'));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body) as List;
      List<Todo> list = jsonList.map((data) => Todo.fromJson(data)).toList();

      return list;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> showCompanyInfoDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user.company.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.company.catchPhrase),
              const SizedBox(height: 8),
              Text('(${user.company.bs})',
                  style: const TextStyle(fontSize: 14, color: Colors.grey)
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }

  void showTodosBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FutureBuilder<List<Todo>>(
          future: _todoList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error!  ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.93,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: ListView.builder(

                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var todo = snapshot.data![index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: todo.completed,
                    title: Text(todo.title),
                    onChanged: (val) {});
                }
              ),
            );
          }
        );
      },
    );
  }
}
