import 'package:flutter/material.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  bool flag = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        flag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: flag ? const Color.fromRGBO(168, 40, 40, 1) : null,
        body: AnimatedCrossFade(
            firstChild: FirstChild(size: size),
            secondChild: const SecondChild(),
            firstCurve: Curves.easeInCubic,
            secondCurve: Curves.easeInCirc,
            crossFadeState:
                flag ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 400)));
  }
}

class FirstChild extends StatelessWidget {
  final Size size;
  const FirstChild({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset('asset/images/logo/CredStream-1.gif'));
  }
}

class SecondChild extends StatelessWidget {
  const SecondChild({super.key});

  @override
  Widget build(BuildContext context) {
    bool flag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const Spacer(),
          Column(
            children: [
              flag
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
                  'stream across boundaries \nThe best OTT ',
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
              const SizedBox(
                height: 18,
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
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
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
