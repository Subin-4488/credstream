import 'dart:math';

import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';

final images = [
  'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/d9nBoowhjiiYc4FBNtQkPY7c11H.jpg',
  'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/njTVPUpWdtZ1wIwNMOwkLVigjXT.jpg',
  'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/t79ozwWnwekO0ADIzsFP1E5SkvR.jpg'
];

final _widgets = [const Section1(), const Section2(), const Section3()];

class ScreenDownloads extends StatelessWidget {
  const ScreenDownloads({super.key});
  @override
  Widget build(BuildContext context) {
    print('Rebuilded downloads');
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppBarWidget(
            title: 'Downloads',
          ),
          kHeight,
          Expanded(
              child: ListView.separated(
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 25,
              );
            }),
            itemBuilder: ((context, index) {
              return _widgets[index];
            }),
            itemCount: _widgets.length,
          )),
        ],
      ),
    );
  }
}

class Section1 extends StatelessWidget {
  const Section1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.settings),
        kWidth,
        Text(
          'Smart Downloads',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Introducing Downloads for You',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        kHeight,
        Text(
          'We\'ll download a personalized selection of\nmovies and shows for you, so there\'s\nalways something to watch on your\ndevice.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: deviceSizePortrait.width * .75,
          width: deviceSizePortrait.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: circleKColor,
                  radius: deviceSizePortrait.width * .32),
              CustomImage(
                img: images[0],
                angle: -18 * pi / 180,
                edgeInsets: const EdgeInsets.only(right: 150, bottom: 30),
              ),
              CustomImage(
                img: images[2],
                angle: 18 * pi / 180,
                edgeInsets: const EdgeInsets.only(left: 150, bottom: 30),
              ),
              CustomImage(
                img: images[1],
                angle: 0,
                edgeInsets: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Set Up'))),
        SizedBox(
            width: deviceSizePortrait.width * .8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kWhite, foregroundColor: kBlack),
                onPressed: () {},
                child: const Text('See what you can download'))),
      ],
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage(
      {Key? key,
      required this.img,
      required this.angle,
      required this.edgeInsets})
      : super(key: key);

  final String img;
  final double angle;
  final EdgeInsets edgeInsets;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
          margin: edgeInsets,
          height: deviceSizePortrait.height * .25,
          width: deviceSizePortrait.width * .35,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(img)))),
    );
  }
}

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
          style: Theme.of(context).textTheme.displayLarge,
        )),
        const Icon(Icons.cast),
      ],
    );
  }
}
