import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/auth/signup.dart';
import 'package:credstream/screens/main_page/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainAuth extends StatelessWidget {
  const MainAuth({super.key});

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    deviceDarkThemeFlag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    return const Scaffold(body: FirstChild());
  }
}

class FirstChild extends StatelessWidget {
  const FirstChild({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      indexNotifier.value = 0;
      Signup.dob.value = DateTime(1920);
    });

    Signup.dob.value = DateTime(1920);
    return SizedBox(
      height: deviceSize.height,
      child: Column(
        children: [
          const Spacer(),
          Column(
            children: [
              deviceDarkThemeFlag
                  ? Image.asset('asset/images/logo/CredStream-logos_white1.png')
                  : Image.asset(
                      'asset/images/logo/CredStream-logos_black1.png'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'CredStream',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Stream across boundaries \nThe best OTT ',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Button(
                label: "Log in",
                index: 0,
              ),
              const Button(label: "Sign up", index: 1),
              SizedBox(
                height: deviceSize.height * .05,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String label;
  final int index;
  const Button({
    super.key,
    required this.label,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceSize.width * .9,
      child: ElevatedButton(
        onPressed: () {
          if (index == 0) {
            Navigator.of(context).pushNamed("login");
          } else {
            Navigator.of(context).pushNamed("signup");
          }
        },
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
