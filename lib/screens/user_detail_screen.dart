import 'package:finalproject/models/user.dart';
import 'package:finalproject/screens/user_info_tile.dart';
import 'package:finalproject/utils/strings.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

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
                const SizedBox(height: 30),
                UserInfoTile(
                  title: Strings.email,
                  body: user.email,
                icon: Icons.email),
                const Divider(height: 30, thickness: 1),
                UserInfoTile(
                    title: Strings.phoneEng,
                    body: user.phone,
                    icon: Icons.phone),
                const Divider(height: 30, thickness: 1),
                UserInfoTile(
                    title: Strings.website,
                    body: user.website,
                    icon: Icons.web),
                const Divider(height: 30, thickness: 1),
                UserInfoTile(
                    title: Strings.company,
                    body: user.company.name,
                    icon: Icons.work),
                const Divider(height: 30, thickness: 1),
                UserInfoTile(
                    title: Strings.address,
                    body: '${user.address.street}, '
                        '${user.address.suite}, '
                        '${user.address.city}, '
                        '${user.address.zipcode}',
                    icon: Icons.location_on),
              ],
            ),
        )
    );
  }
}
