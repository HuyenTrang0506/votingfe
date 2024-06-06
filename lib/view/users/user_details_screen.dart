import 'package:flutter/material.dart';
import 'package:flutter_application/components/app_title.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(usersViewModel.selectedUser.fullname ?? ''),
      ),
      body: Container(
        
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(text: usersViewModel.selectedUser.fullname ?? ''),
            SizedBox(height: 5.0),
            Text(
              usersViewModel.selectedUser.email??'',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 5.0),
            Text(
              usersViewModel.selectedUser.avatarUrl ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
