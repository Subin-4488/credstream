import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/home/widgets/main_card.dart';
import 'package:credstream/screens/screen_widgets/main_title.dart';

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
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5), 
          child: MainTitle(title: title),
        ),
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
