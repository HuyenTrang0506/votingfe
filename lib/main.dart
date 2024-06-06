import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/view/auth/welcome_screen.dart';
import 'package:flutter_application/view_model/login_register_view_model.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UsersViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel())
        ],
        child: MaterialApp(
          title: 'Voting App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const WelcomeScreen(),
        ));
  }
}
