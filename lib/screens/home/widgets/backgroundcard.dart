import 'package:credstream/dummy.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      height: size.height * .75,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(mainImage), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * .09,
              color: brightness == Brightness.dark
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
    Brightness brightness = MediaQuery.of(context).platformBrightness;
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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: brightness == Brightness.dark ? kWhite : kBlack),
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
          return const Dummy();
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
                .copyWith(color: kRed, fontFamily: 'Unbounded')),
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhite)),
    );
  }
}
