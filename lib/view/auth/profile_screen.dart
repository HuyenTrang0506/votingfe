import 'package:flutter/material.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(model.userModel.avatarUrl ?? ''),
                ),
                Text(model.userModel.fullname ?? ''),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to edit profile screen
                  },
                ),
                Text(model.userModel.email ?? ''),
                Text(model.userModel.pro == true
                    ? "Premium Version"
                    : "Not Premium Version"),
                if (model.userModel.pro == false)
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to upgrade screen
                    },
                    child: Text('Upgrade to Premium'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    model.logout();
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
