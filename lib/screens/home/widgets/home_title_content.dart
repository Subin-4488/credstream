import 'package:credstream/core/colors.dart';
import 'package:credstream/models/video.dart';
import 'package:credstream/player/player.dart';
import 'package:credstream/provider/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/home/widgets/main_card.dart';
import 'package:credstream/screens/screen_widgets/main_title.dart';
import 'package:provider/provider.dart';

class HomeTitleContent extends StatelessWidget {
  final Future<Map<String, List<Video>>> Function() future;
  const HomeTitleContent({
    Key? key,
    required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future.call(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            Map<String, List<Video>> data = snapshot.data!;
            return Column(
              children: data.entries
                  .map((entry) => Item(title: entry.key, list: entry.value))
                  .toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class Item extends StatelessWidget {
  final String title;
  final List<Video> list;
  const Item({required this.title, required this.list, super.key});

  @override
  Widget build(BuildContext context) { 
    return SizedBox(
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
            child: MainTitle(title: title.trim().toUpperCase(), color: kBlack,), 
          ),
          kHeight5,
          LimitedBox( 
            maxHeight: 200,
            child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Consumer<LoadingProvider>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () async {
                        value.startLoading();
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayer(videomodel: list[index]),
                        ));
                        value.stopLoading();
                      },
                      child: title.compareTo("Game") == 0
                          ? Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  child: MainCard(
                                    image: list[index].image,
                                  ),
                                ),
                                Text(
                                  '${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 85, color: kBlue),
                                ),
                              ],
                            )
                          : MainCard(
                              image: list[index].image,
                            ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
