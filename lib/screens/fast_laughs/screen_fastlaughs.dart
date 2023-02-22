import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';
import 'package:credstream/screens/fast_laughs/widgets/circle_action_widget.dart';

class ScreenFastlaughs extends StatelessWidget {
  ScreenFastlaughs({super.key});
  final pageController = PageController(viewportFraction: .9);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          children: List.generate(10, (index) => const Pages()),
        ),
        const PageActions()
      ],
    );
  }
}

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.accents[Random().nextInt(Colors.accents.length - 1)],
    );
  }
}

class PageActions extends StatelessWidget {
  const PageActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black.withOpacity(.6),
            child: IconButton(
                onPressed: (() {}),
                icon: const Icon(CupertinoIcons.volume_off)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(images[0]),
              ),
              const CircleActionWidget(
                  size: 13,
                  color: kBlack,
                  icondata: Icons.emoji_emotions_outlined,
                  string: 'LOL'),
              const CircleActionWidget(
                  size: 13,
                  color: kBlack,
                  icondata: Icons.add,
                  string: 'My List'),
              const CircleActionWidget(
                  size: 13,
                  color: kBlack,
                  icondata: Icons.share,
                  string: 'Share'),
              const CircleActionWidget(
                  size: 13,
                  color: kBlack,
                  icondata: Icons.play_arrow,
                  string: 'Play'),
            ],
          )
        ],
      ),
    );
  }
}
