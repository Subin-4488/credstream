import 'package:credstream/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';
import 'package:credstream/screens/screen_widgets/main_title.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        MainTitle(title: 'Movies & TV', color: kBlack),
        kHeight,
        Expanded(child: ResultsWidget())
      ],
    ));
  }
}

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      childAspectRatio: 1 / 1.4,
      children: List.generate(15, (index) {
        return Container(
            decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(images[2])),
        ));
      }),
    );
  }
}
