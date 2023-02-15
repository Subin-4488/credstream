import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';

ValueNotifier<int> indexNotifier = ValueNotifier(0);

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexNotifier,
      builder: (context, value, child) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kBlack,
            showUnselectedLabels: true,
            currentIndex: indexNotifier.value,
            onTap: ((value) {
              indexNotifier.value = value;
            }),
            selectedIconTheme: const IconThemeData(color: kWhite),
            selectedItemColor: kWhite,
            unselectedItemColor: Colors.grey,
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.collections), label: 'new&hot'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_emotions), label: 'fastlaughs'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.download), label: 'downloads')
            ]);
      },
    );
  }
}
