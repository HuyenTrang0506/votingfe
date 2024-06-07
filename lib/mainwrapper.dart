import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/navigations/add_election_navigation.dart';
import 'package:flutter_application/navigations/elections_navigation.dart';
import 'package:flutter_application/navigations/history_navigation.dart';
import 'package:flutter_application/navigations/home_navigation.dart';
import 'package:flutter_application/navigations/profile_navigation.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex]
          .currentState
          ?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true; // Indicate that the back action is handled
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = context.read<AuthViewModel>().userModel;

    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          destinations: [
            if (currentUser.roles!.contains('ROLE_ADMIN'))
              NavigationDestination(
                selectedIcon: Icon(Icons.house),
                icon: Icon(Icons.house_outlined),
                label: 'User',
              ),
            if (currentUser.roles!.contains('ROLE_ADMIN'))
              NavigationDestination(
                selectedIcon: Icon(Icons.add),
                icon: Icon(Icons.add_outlined),
                label: 'Create',
              ),
            NavigationDestination(
              selectedIcon: Icon(Icons.how_to_vote),
              icon: Icon(Icons.how_to_vote_outlined),
              label: 'Elections',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.history),
              icon: Icon(Icons.history_outlined),
              label: 'History',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _selectedIndex,
            children: currentUser.roles!.contains('ROLE_ADMIN')
                ? <Widget>[
                    HomeNavigator(),
                    AddElectionNavigator(),
                    ElectionNavigator(),
                    HistoryNavigator(),
                    ProfileNavigator(),
                  ]
                : <Widget>[
                    ElectionNavigator(),
                    HistoryNavigator(),
                    ProfileNavigator(),
                  ],
          ),
        ),
      ),
    );
  }
}
