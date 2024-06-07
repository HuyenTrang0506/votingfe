import 'package:flutter/material.dart';
import 'package:flutter_application/view/auth/profile_screen.dart';
import 'package:flutter_application/view/users/add_user_screen.dart';

import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view/users/users_screen.dart';

class ProfileNavigator extends StatefulWidget {
  const ProfileNavigator({super.key});

  @override
 ProfileNavigatorState createState() => ProfileNavigatorState();
}

GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>();

class ProfileNavigatorState  extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: profileNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
           
            return ProfileScreen();
          },
        );
      },
    );
  }
}
