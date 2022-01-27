import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    Key? key,
    required this.title,
    required this.body,
    required this.prefixIcon,
    this.postfixIcon,
  }) : super(key: key);

  final String title, body;
  final IconData prefixIcon;
  final IconData? postfixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 10.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(prefixIcon, color: Colors.blue, size: 24.w),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  body,
                  style: TextStyle(
                    fontSize: 19.sp,
                  ),
                ),
              ),
              postfixIcon == null?
              const SizedBox():
              Icon(postfixIcon, color: Colors.grey[400], size: 18.w),
            ],
          )
        ],
      ),
    );
  }
}
