import 'package:flutter/material.dart';
import 'package:flutter_application/view/elections/history_screen.dart';
import 'package:flutter_application/view/users/add_user_screen.dart';

import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view/users/users_screen.dart';

class HistoryNavigator extends StatefulWidget {
  const HistoryNavigator({super.key});

  @override
  HistoryNavigatorState createState() => HistoryNavigatorState();
}

GlobalKey<NavigatorState> historyNavigatorKey = GlobalKey<NavigatorState>();

class HistoryNavigatorState extends State<HistoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: historyNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
           
            return HistoryScreen();
          },
        );
      },
    );
  }
}
