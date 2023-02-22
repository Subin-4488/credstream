import 'package:credstream/core/apptheme.dart';
import 'package:credstream/screens/auth/login.dart';
import 'package:credstream/screens/auth/signup.dart';
import 'package:credstream/screens/auth/widgets/main_auth.dart';
import 'package:flutter/material.dart';
import 'package:credstream/screens/main_page/main_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        "main_auth": (context) =>  MainAuth(),
        "mainPage": (context) => MainPage(),
        "login" :(context) => Login(),
        "signup" :(context) => Signup()
      },
      initialRoute: "main_auth", 
    );
  }
}
