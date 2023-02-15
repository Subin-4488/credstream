import 'package:credstream/dummy.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/main_page/main_page.dart';

void 
main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme:
              const TextTheme(headline1: headingStyle, bodyText1: bodyStyle)),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
