import 'package:credstream/core/values.dart';
import 'package:credstream/models/video.dart';
import 'package:credstream/player/player.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSizePortrait.height * .75,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(mainImage), fit: BoxFit.fill)), 
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: deviceSizePortrait.height * .09,
              color: deviceDarkThemeFlag
                  ? kFloatingContainerDark
                  : kFloatingContainerLight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                HomeCustomButton(
                  iconData: Icons.add,
                  text: 'My List',
                ),
                PlayButton(),
                HomeCustomButton(
                  iconData: Icons.info,
                  text: 'Info',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCustomButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  const HomeCustomButton({
    required this.iconData,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: (() {}),
            child: Column(
              children: [
                Icon(
                  iconData,
                ),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: deviceDarkThemeFlag ? kWhite : kBlack),
                )
              ],
            ))
      ],
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: (() {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return VideoPlayer(
            videomodel: Video(
              ownership: 'Ubisoft',
                link: "$baseUrl/output/stream.m3u8", 
                genre: 'Action',
                year: 2022,
                image: mainImage,
                name: 'Avatar: The Way of Water',
                description:
                    'To explore Pandora, genetically matched human scientists use Na\'vi-human hybrids called "avatars." Paraplegic Marine Jake Sully is sent to Pandora to replace his deceased identical twin, who had signed up to be an operator.'),
          );
        })));
      }),
      icon: const Icon(
        Icons.play_arrow,
        size: 25,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text('Play',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: kBlue, fontFamily: 'Unbounded')),
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhite)),
    );
  }
}
