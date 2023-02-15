import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/fast_laughs/widgets/circle_action_widget.dart';

class EveryoneWatching extends StatelessWidget {
  const EveryoneWatching({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListItem();
          },
          separatorBuilder: ((context, index) {
            return kHeight20;
          }),
          itemCount: 10),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tall Girl 2',
          style: headingStyle.copyWith(fontSize: 19),
        ),
        kHeight,
        const Text(
          'Landing the lead in the school musical is adream come true for jodi, until the pressure sends her confidence - and her relationship - into tailspain',
          style: bodyStyle,
        ),
        VideoWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CircleActionWidget(
                icondata: Icons.share,
                string: 'Share',
                color: kWhite,
                size: 12),
            kWidth20,
            CircleActionWidget(
                icondata: Icons.add,
                string: 'My List',
                color: kWhite,
                size: 12),
            kWidth20,
            CircleActionWidget(
                icondata: Icons.play_arrow,
                string: 'Share',
                color: kWhite,
                size: 12),
          ],
        )
      ],
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
            width: double.infinity,
            child: Image.network(
                fit: BoxFit.cover,
                'https://www.themoviedb.org/t/p/w355_and_h200_multi_faces/gQxaF79LUTtopdYHsuS8lUr9rvF.jpg')),
        IconButton(onPressed: (() {}), icon: Icon(Icons.volume_off))
      ],
    );
  }
}
