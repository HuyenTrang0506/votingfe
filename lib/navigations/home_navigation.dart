import 'package:flutter/material.dart';
import 'package:flutter_application/view/users/add_user_screen.dart';

import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view/users/users_screen.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  HomeNavigatorState createState() => HomeNavigatorState();
}

GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            if (settings.name == "/addUser") {
              return AddUserScreen();
            }
            if (settings.name == "/detailUser") {
              return  UserDetailsScreen();
            }
            return UsersScreen();
          },
        );
      },
    );
  }
}
