import 'package:flutter/material.dart';
import 'package:flutter_application/view/users/profile/involve.dart';
import 'package:flutter_application/view/users/profile/profile.dart';

class ProfileNavigator extends StatefulWidget {
  const ProfileNavigator({super.key});

  @override
  ProfileNavigatorState createState() => ProfileNavigatorState();
}

GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>();

class ProfileNavigatorState extends State<ProfileNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: profileNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            if (settings.name == "/bill") {
              return bill();
            }
            return ProfileScreen();
          },
        );
      },
    );
  }
}
