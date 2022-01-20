import 'dart:convert';

import 'package:finalproject/models/user.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:finalproject/widgets/user_info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
                  height: 410.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/avatar.png')
                      )
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 65.h,
                        left: 4.w,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back, color: Colors.white))
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, bottom: 3.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(user.name,
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text('(${user.username})',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white70,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {sendEmail(user.email);},
                  child: UserInfoTile(
                    title: Strings.email,
                    body: user.email,
                    icon: Icons.email),
                ),
                Divider(thickness: 1.h),
                InkWell(
                  onTap: () {makeCall(user.phone);},
                  child: UserInfoTile(
                      title: Strings.phoneEng,
                      body: user.phone,
                      icon: Icons.phone),
                ),
                Divider(thickness: 1.h),
                InkWell(
                  onTap: () {openWebsite(user.website);},
                  child: UserInfoTile(
                      title: Strings.website,
                      body: user.website,
                      icon: Icons.web),
                ),
                Divider(thickness: 1.h),
                InkWell(
                  onTap: () => showCompanyInfoDialog(context),
                  child: UserInfoTile(
                      title: Strings.company,
                      body: user.company.name,
                      icon: Icons.work),
                ),
                Divider(thickness: 1.h),
                UserInfoTile(
                    title: Strings.address,
                    body: '${user.address.street}, '
                        '${user.address.suite}, '
                        '${user.address.city}, '
                        '${user.address.zipcode}',
                    icon: Icons.location_on),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: OutlinedButton(
                    onPressed: () {
                      _todoList = fetchTodos(user.id);
                      showTodosBottomSheet(context);
                      },
                    child: Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: Row(
                        children: [
                          Text(Strings.todos, style: TextStyle(fontSize: 18.sp)
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, color: Colors.grey),
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
              SizedBox(height: 8.h),
              Text('(${user.company.bs})',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey)
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
              padding: EdgeInsets.all(20.r),
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0.r),
                  topRight: Radius.circular(25.0.r),
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

  Future sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Hello!'
      }),
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    }  
  }

  Future makeCall(String tel) async {
    final Uri emailUri = Uri(
      scheme: 'tel',
      path: tel,
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    }
  }

  Future openWebsite(String website) async {
    final Uri emailUri = Uri(
      scheme: 'https',
      path: website,
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    }
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
