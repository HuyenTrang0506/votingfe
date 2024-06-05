import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';

import 'app_title.dart';

class UserListRow extends StatelessWidget {
  final UserModel userModel;
  final Function onTap;
  UserListRow({required this.userModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(text: userModel.fullname ?? ''),
            Text(
                userModel.email ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
