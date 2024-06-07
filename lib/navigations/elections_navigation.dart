import 'package:flutter/material.dart';
import 'package:flutter_application/view/elections/add_election_screen.dart';
import 'package:flutter_application/view/elections/elections_screen.dart';

import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view/users/users_screen.dart';

class ElectionNavigator extends StatefulWidget {
  const ElectionNavigator({super.key});

  @override
  ElectionNavigatorState createState() => ElectionNavigatorState();
}

GlobalKey<NavigatorState> electionsNavigatorKey = GlobalKey<NavigatorState>();

class ElectionNavigatorState extends State<ElectionNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: electionsNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            if (settings.name == "/joinElection") {
              return CreateScreen();
            }
            if (settings.name == "/modifyElection") {
              return CreateScreen();
            }
            return ElectionScreen();
          },
        );
      },
    );
  }
}
