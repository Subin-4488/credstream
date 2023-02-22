import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';

class CircleActionWidget extends StatelessWidget {
  final IconData icondata;
  final String string;
  final Color color;
  final double size;
  const CircleActionWidget(
      {super.key,
      required this.icondata,
      required this.string,
      required this.color,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight,
        Icon(
          icondata,
          size: 30,
        ),
        Text(
          string,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
