import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/downloads/screen_downloads.dart';
import 'package:credstream/screens/screen_widgets/main_title.dart';

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(title: 'Top Searches'),
          kHeight,
          Expanded(child: SearchItems())
        ],
      ),
    );
  }
}

class SearchItems extends StatelessWidget {
  const SearchItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
        itemBuilder: ((context, index) {
          return Row(
            children: [
              Container(
                height: size.height * .1,
                width: size.width * .38,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(images[0]), fit: BoxFit.cover)),
              ),
              kWidth,
              const Expanded(
                  child: Text(
                'Titanic',
              )),
              const CircleAvatar(
                  backgroundColor: kWhite,
                  radius: 25,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundColor: kBlack,
                    child: Icon(CupertinoIcons.play_fill),
                  ))
            ],
          );
        }),
        separatorBuilder: ((context, index) {
          return kHeight20;
        }),
        itemCount: 10);
  }
}
