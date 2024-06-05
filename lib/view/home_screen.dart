import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_application/components/app_loading.dart';
import 'package:flutter_application/components/app_error.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/components/user_list_row.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            onPressed: () async {
              // openAddUser(context);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              usersViewModel.getUsers();
    
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _ui(usersViewModel),
          ],
        ),
      ),
    );
  }

  _ui(UsersViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return AppLoading();
    }
    if (usersViewModel.userError != null) {
      return AppError(
        errortxt: usersViewModel.userError?.message,
      );
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = usersViewModel.userListModel[index];
        
          return UserListRow(
            userModel: userModel,
            onTap: () async {
              // usersViewModel.setSelectedUser(userModel);
              // openUserDetails(context);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }
}
