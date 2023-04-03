import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/provider/loadingProvider.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:credstream/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';
import 'package:credstream/screens/home/screen_home.dart';
import 'package:credstream/screens/main_page/widgets/bottom_navigation_bar.dart';
import 'package:credstream/screens/search/screen_search.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final _pages = [
    const ScreenHome(),
    const ScreenSearch(),
    const ScreenDownloads(),
    const Settings()
  ];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    deviceSizePortrait = MediaQuery.of(context).size;
    deviceDarkThemeFlag =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? true 
            : false;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: indexNotifier,
                builder: ((context, value, child) {
                  return _pages[value];
                })),
            Consumer<LoadingProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.loading,
                  child: Container(
                      color: deviceDarkThemeFlag ? kBlack : kWhite,
                      height: deviceSizePortrait.height,
                      width: deviceSizePortrait.width,
                      child: const Loading()),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
