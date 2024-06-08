import 'package:flutter/material.dart';
import 'package:flutter_application/components/app_error.dart';
import 'package:flutter_application/components/app_loading.dart';
import 'package:flutter_application/components/user_list_row.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? accessToken = Provider.of<AuthViewModel>(context, listen: false)
          .userCurrentModel
          .accessToken;
      if (accessToken != null) {
        Provider.of<UsersViewModel>(context, listen: false)
            .getUsers(accessToken); // Adjusted to use Provider for consistency
      }
    });
  }

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
              Navigator.pushNamed(context, '/detailUser');
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              String? accessToken =
                  context.read<AuthViewModel>().userCurrentModel.accessToken;

              if (accessToken != null) {
                usersViewModel.getUsers(accessToken);
              }
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
              usersViewModel.setSelectedUser(userModel);
              Navigator.pushNamed(context, '/detailUser');
            },
            onDelete: () {
              String? accessToken =
                  context.read<AuthViewModel>().userCurrentModel.accessToken;
              if (accessToken != null) {
                usersViewModel.setSelectedUser(userModel);
                print("delete ");

                usersViewModel.deleteUser(accessToken, userModel.id.toString());
                print(usersViewModel);
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }

  void openUserDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen()),
    );
  }
}
