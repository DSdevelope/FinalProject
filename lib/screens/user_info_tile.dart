import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    Key? key,
    required this.title,
    required this.body,
    required this.icon,
  }) : super(key: key);

  final String title, body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  body,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
