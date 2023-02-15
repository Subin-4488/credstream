import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/widgets/main_card.dart';
import 'package:credstream/screens/widgets/main_title.dart';

class HomeTitleContent extends StatelessWidget {
  final String title;
  const HomeTitleContent({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(10, (index) => const MainCard()),
          ),
        ),
        kHeight20
      ],
    );
  }
}
