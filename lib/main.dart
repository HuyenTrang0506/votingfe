import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/mainwrapper.dart';
import 'package:flutter_application/view/auth/signin_screen.dart';
import 'package:flutter_application/view/auth/welcome_screen.dart';
import 'package:flutter_application/view_model/auth_view_model.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UsersViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<AuthViewModel>(
          builder: (context, authViewModel, child) {
            if (authViewModel.isAuthenticated) {
              print ("Authenticated");
              return MainWrapper();
            } else {
              print(authViewModel.isAuthenticated);
               print("Isn't Authenticated");
              return SignInScreen();
            }
          },
        )
          
    );
  }
}
