import 'package:flutter/material.dart';
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
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '12',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
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
        SizedBox(
          height: size.height * .28,
          child: Image.network(
            'https://www.themoviedb.org/t/p/w355_and_h200_multi_faces/9ijMGlJKqcslswWUzTEwScm82Gs.jpg',
            fit: BoxFit.cover,
          ),
        ),
        kHeight,
        Row(
          children:  [
            Expanded(
                child: Text(
              'TALLGIRL 2',
              style: Theme.of(context).textTheme.bodyLarge,
            )),
            kWidth,
            const CircleActionWidget(
              size: 12,
              icondata: Icons.notifications,
              string: 'Remind Me',
              color: Colors.grey,
            ),
            const SizedBox(width: 5,),
            const CircleActionWidget(
              size: 12,
              icondata: Icons.warning,
              string: 'Info',
              color: Colors.grey,
            )
          ],
        ),
         Text(
          'Coming on Friday',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        kHeight,
         Text(
          'Tall Girl 2',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
         Text(
          'Landing the lead in the school musical is a dream come true for jodi, until the pressure sends her confidence - and her relationship - into tailspain',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
