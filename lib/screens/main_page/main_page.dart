import 'package:credstream/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';
import 'package:credstream/screens/home/screen_home.dart';
import 'package:credstream/screens/main_page/widgets/bottom_navigation_bar.dart';
import 'package:credstream/screens/search/screen_search.dart';

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
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexNotifier,
            builder: ((context, value, child) {
              return _pages[value];
            })),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
