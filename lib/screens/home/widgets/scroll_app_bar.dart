import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/home/screen_home.dart';

class ScrollAppBar extends StatelessWidget {
  const ScrollAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hometitleNotifier,
      builder: (context, value, child) {
        return AnimatedContainer(
          color: Colors.black45,
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
                    Image.network(
                        height: 40,
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Netflix-new-icon.png/900px-Netflix-new-icon.png?20160722094621'),
                    const Spacer(),
                    const Icon(Icons.cast),
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
    return TextButton(
        onPressed: (() {}),
        child: Text(
          text,
          style: bodyStyle,
        ));
  }
}
