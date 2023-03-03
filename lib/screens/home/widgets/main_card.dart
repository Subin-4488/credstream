import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        height: size.height * .28,
        width: size.width * .40,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
                image: NetworkImage(images[0]), fit: BoxFit.cover)),
      ),
    );
  }
}
