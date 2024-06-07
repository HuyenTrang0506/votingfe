import 'package:flutter/material.dart';
import 'package:flutter_application/view/elections/add_election_screen.dart';
import 'package:flutter_application/view/elections/elections_screen.dart';

import 'package:flutter_application/view/users/user_details_screen.dart';
import 'package:flutter_application/view/users/users_screen.dart';

class AddElectionNavigator extends StatefulWidget {
  const AddElectionNavigator({super.key});

  @override
  AddElectionNavigatorState createState() => AddElectionNavigatorState();
}

GlobalKey<NavigatorState> addElectionsNavigatorKey = GlobalKey<NavigatorState>();

class AddElectionNavigatorState extends State<AddElectionNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: addElectionsNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
          
            return CreatePollScreen();
          },
        );
      },
    );
  }
}
