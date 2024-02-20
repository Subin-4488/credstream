import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String title;
  MainTitle({super.key, required this.title});

  @override 
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme
    .displayLarge!.copyWith(fontWeight: FontWeight.bold));
  }
}
