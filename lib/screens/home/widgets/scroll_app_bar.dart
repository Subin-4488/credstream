import 'package:credstream/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:credstream/screens/home/screen_home.dart';

class ScrollAppBar extends StatelessWidget {
  const ScrollAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return ValueListenableBuilder(
      valueListenable: hometitleNotifier,
      builder: (context, value, child) {
        return AnimatedContainer(
          decoration: BoxDecoration(
              color: brightness == Brightness.dark
                  ? kFloatingContainerDark
                  : kFloatingContainerLight,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          width: size.width,
          alignment: Alignment.center,
          height: animatedContainerheight,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(brightness == Brightness.light
                        ? 'asset/images/logo/CredStream-logos_black1.png'
                        : 'asset/images/logo/CredStream-logos_white1.png'),
                    Text(
                      'CredStream',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: kBlue, fontSize: 20),
                    ),
                    const Spacer(),
                    const Icon(Icons.cast),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    TItleTextButtons(text: 'TV Shows'),
                    TItleTextButtons(text: 'Movies'),
                    TItleTextButtons(text: 'Categories'),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class TItleTextButtons extends StatelessWidget {
  final String text;
  const TItleTextButtons({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return TextButton(
        onPressed: (() {}),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: brightness == Brightness.dark ? kWhite : kBlack),
        ));
  }
}
