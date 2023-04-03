import 'package:credstream/domain/video/video_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/home/widgets/backgroundcard.dart';
import 'package:credstream/screens/home/widgets/home_title_content.dart';
import 'package:credstream/screens/home/widgets/scroll_app_bar.dart';

final ValueNotifier<bool> hometitleNotifier = ValueNotifier(true);
double animatedContainerheight = -1;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    if (animatedContainerheight == -1) {
      animatedContainerheight = deviceSizePortrait.height * .114;
    }
    return NotificationListener<UserScrollNotification>(
      onNotification: ((notification) {
        if (notification.direction == ScrollDirection.forward) {
          hometitleNotifier.value = true;
          animatedContainerheight = deviceSizePortrait.height * .114;
        } else if (notification.direction == ScrollDirection.reverse) {
          hometitleNotifier.value = false;
          animatedContainerheight = 0;
        }
        hometitleNotifier.notifyListeners();
        return true;
      }),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                BackgroundCard(),
                kHeight20,         
                HomeTitleContent(future: VideoApi.populateVideos),
              ],
            ),
          ),
          const ScrollAppBar(),
        ],
      ), 
    );
  }
}