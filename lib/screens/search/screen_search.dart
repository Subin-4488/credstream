import 'package:credstream/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/search/widgets/search_results.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoSearchTextField(
            placeholderStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontFamily: 'Nunito'),
            padding: const EdgeInsets.all(10),
            backgroundColor: kBlue, 
            style: Theme.of(context).textTheme.bodyLarge,
            prefixIcon: const Icon(
              Icons.search,
              color: kBlack,
            ),
            suffixIcon: const Icon(
              Icons.cancel,
              color: kRed,
            ),
          ),
          kHeight,
          const SearchResults(),
        ],
      ),
    );
  }
}
