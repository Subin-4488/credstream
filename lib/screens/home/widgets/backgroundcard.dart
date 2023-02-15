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
              color: Colors.black45,
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
                  color: kWhite,
                ),
                Text(text,
                    style: headingStyle.copyWith(color: kWhite, fontSize: 15))
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
          return Dummy();
        })));
      }),
      icon: const Icon(
        Icons.play_arrow,
        size: 25,
        color: kBlack,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          'Play',
          style: headingStyle.copyWith(color: kBlack, fontSize: 15),
        ),
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhite)),
    );
  }
}
