import 'package:credstream/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/home/widgets/backgroundcard.dart';
import 'package:credstream/screens/home/widgets/home_title_content.dart';
import 'package:credstream/screens/home/widgets/scroll_app_bar.dart';
import 'package:credstream/screens/home/widgets/main_card.dart';
import 'package:credstream/screens/screen_widgets/main_title.dart';

final ValueNotifier<bool> hometitleNotifier = ValueNotifier(true);
double animatedContainerheight = -1;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (animatedContainerheight == -1) {
      animatedContainerheight = size.height * .114;
    }
    return NotificationListener<UserScrollNotification>(
      onNotification: ((notification) {
        if (notification.direction == ScrollDirection.forward) {
          hometitleNotifier.value = true;
          animatedContainerheight = size.height * .114;
        } else if (notification.direction == ScrollDirection.reverse) {
          hometitleNotifier.value = false;
          animatedContainerheight = 0;
        }
        hometitleNotifier.notifyListeners();
        return true;
      }),
      child: Stack(
        children: [
          ListView(
            children: [
              BackgroundCard(size: size),
              const SizedBox(
                height: 2,
              ),
              const HomeTitleContent(title: 'Released in the past year'),
              const HomeTitleContent(title: 'Trending Now'),
              const NumberedHomeTitleContent(),
              const HomeTitleContent(title: 'South Indian Cinemas'),
            ],
          ),
          ScrollAppBar(size: size),
        ],
      ),
    );
  }
}

class NumberedHomeTitleContent extends StatelessWidget {
  const NumberedHomeTitleContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15, top: 5),
          child: MainTitle(title: 'Top 10 TV Shows in India Today'),
        ),
        kHeight,
        Padding(
          padding: const EdgeInsets.only(left:4.0),
          child: LimitedBox(
            maxHeight: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  10,
                  (index) => Stack(alignment: Alignment.bottomLeft, children: [
                        Container(
                            margin: const EdgeInsets.only(left: 30),  
                            child: const MainCard()),
                        Text(
                          '${index + 1}', 
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 85,color: kBlue),
                        ),
                      ])),
            ),
          ),
        ),
        kHeight20
      ],
    );
  }
}
