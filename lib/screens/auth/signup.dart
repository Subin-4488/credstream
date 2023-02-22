import 'package:credstream/screens/auth/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  // final _key = GlobalKey<FormState>();

  ValueNotifier<bool> dragNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    bool flag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    return Scaffold(
        body: GestureDetector(
      onVerticalDragStart: (details) {
        dragNotifier.value = false;
        dragNotifier.notifyListeners();
      },
      onHorizontalDragStart: (details) {
        dragNotifier.value = true;
        dragNotifier.notifyListeners();
      },
      child: ValueListenableBuilder(
        valueListenable: dragNotifier,
        builder: (context, value, child) => AnimatedCrossFade(
            firstChild: flag
                ? Image.asset('asset/images/logo/CredStream-logos_white1.png')
                : Image.asset('asset/images/logo/CredStream-logos_black1.png'),
            secondChild: FormWidget(),
            crossFadeState: dragNotifier.value
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(seconds: 1)),
      ),
    ));
  }
}
