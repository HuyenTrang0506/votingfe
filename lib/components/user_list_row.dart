import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';

import 'app_title.dart';

class UserListRow extends StatelessWidget {
  final UserModel userModel;
  final Function onTap;
  final Function onDelete;

  UserListRow(
      {required this.userModel, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitle(text: userModel.fullname ?? ''),
                Text(
                  userModel.email ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete as void Function()?,
            ),
          ],
        ),
      ),
    );
  }
}
