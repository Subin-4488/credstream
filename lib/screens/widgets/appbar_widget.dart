import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: headingStyle,
        )),
        const Icon(Icons.cast),
      ],
    );
  }
}
