import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/screens/new&hot/widgets/coming_soon.dart';
import 'package:credstream/screens/new&hot/widgets/everyone_watching.dart';
import 'package:credstream/screens/widgets/appbar_widget.dart';

class ScreenNewandhot extends StatelessWidget {
  const ScreenNewandhot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: const [
          AppBarWidget(title: 'New & Hot'),
          Expanded(child: CustomTab()),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool flag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.symmetric(vertical: 15),
              isScrollable: false,
              splashBorderRadius: BorderRadius.circular(25),
              splashFactory: InkSplash.splashFactory,
              unselectedLabelColor: flag ? kWhite : kBlack,
              labelColor: flag ? kBlack : kWhite,
              indicator: BoxDecoration(
                  color: kBlue, borderRadius: BorderRadius.circular(25)),
              tabs: const [
                Tab(
                  text: '🍿 Coming Soon',
                ),
                Tab(
                  text: '😎 Everyone\'s watching',
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.separated(
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return const ComingSoon();
                  }),
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      height: 2,
                    );
                  }),
                ),
                const EveryoneWatching()
              ]),
            )
          ],
        ));
  }
}
