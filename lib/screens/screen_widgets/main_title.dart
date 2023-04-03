import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final Color color;
  final String title;
  const MainTitle({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme
    .displayLarge!.copyWith(color: color, fontWeight: FontWeight.bold));
  }
}
