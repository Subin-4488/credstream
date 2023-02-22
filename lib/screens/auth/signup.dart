import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});
  // final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset('asset/images/logo/CredStream-logos_white.png')
        ],
      ),
    );

    // return Material(
    // child: Stack(
    //   children: [
    //     Image.asset(
    //       'asset/images/logo/CredStream-logos_white.png',
    //     ),
    //     SafeArea(
    //       child: Form(
    //           key: _key,
    //           child: Expanded(
    //             child: Column(
    //               children: [TextFormField(), TextFormField()],
    //             ),
    //           )),
    //     )
    //   ],
    // ),
    // );
  }
}
