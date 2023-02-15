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
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.grey[800],
            style: TextStyle(color: Colors.grey[300]),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[300],
            ),
            suffixIcon: Icon(
              Icons.cancel,
              color: Colors.grey[300],
            ),
          ),
          kHeight,
          const SearchResults(),
        ],
      ),
    );
  }
}
