import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/fast_laughs/widgets/circle_action_widget.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height * .60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Date(
              size: size,
            ),
            kWidth,
            Expanded(
              child: Content(
                size: size,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Date extends StatelessWidget {
  final Size size;
  const Date({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width * .09,
        child: Column(
          children: [
            Text(
              'FEB',
              style: bodyStyle.copyWith(color: kGrey400),
              textAlign: TextAlign.center,
            ),
            const Text(
              '12',
              style: headingStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}

class Content extends StatelessWidget {
  final Size size;
  const Content({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * .28,
          child: Image.network(
            'https://www.themoviedb.org/t/p/w355_and_h200_multi_faces/9ijMGlJKqcslswWUzTEwScm82Gs.jpg',
            fit: BoxFit.cover,
          ),
        ),
        kHeight,
        Row(
          children: const [
            Expanded(
                child: Text(
              'TALLGIRL 2',
              style: headingStyle,
            )),
            kWidth,
            CircleActionWidget(
              size: 12,
              icondata: Icons.notifications,
              string: 'Remind Me',
              color: Colors.grey,
            ),
            CircleActionWidget(
              size: 12,
              icondata: Icons.warning,
              string: 'Info',
              color: Colors.grey,
            )
          ],
        ),
        const Text(
          'Coming on Friday',
          style: bodyStyle,
        ),
        kHeight,
        Text(
          'Tall Girl 2',
          style: headingStyle.copyWith(fontSize: 19),
        ),
        const Text(
          'Landing the lead in the school musical is a dream come true for jodi, until the pressure sends her confidence - and her relationship - into tailspain',
          style: bodyStyle,
        )
      ],
    );
  }
}
