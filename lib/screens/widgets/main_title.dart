import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';

class MainTitle extends StatelessWidget {
  final String title;
  const MainTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: headingStyle.copyWith(fontSize: 19),
    );
  }
}
