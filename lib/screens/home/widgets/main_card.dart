import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';

class MainCard extends StatelessWidget {
  final String image;
  const MainCard({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        height: deviceSize.height * .28,
        width: deviceSize.width * .40,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
                image: CachedNetworkImageProvider(image), fit: BoxFit.fill)),
      ),
    );
  }
}
