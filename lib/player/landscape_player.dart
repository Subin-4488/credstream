import 'dart:async';
import 'dart:math';

import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LandScapePlayer extends StatefulWidget {
  final String watermark;
  final String link;

  LandScapePlayer({required this.link, required this.watermark, super.key});

  @override
  State<LandScapePlayer> createState() => _LandScapePlayerState();
}

class _LandScapePlayerState extends State<LandScapePlayer> {
  Timer? timer;
  double top = 0;
  double left = 0;
  bool _visible = true;
  IconData _iconData = Icons.pause;

  late double topMAX, leftMAX;

  late VideoPlayerController _controller;

  bool _controlsVisible = true;

  bool _loading = false;

  void updateLocation() {
    Random random = Random();
    double newTop = random.nextInt(topMAX.toInt()).toDouble();
    double newLeft = random.nextInt(leftMAX.toInt()).toDouble();
    if (newTop + 30 > topMAX) {
      newTop = topMAX - 30;
    }
    if (newLeft + 60 > leftMAX) {
      newLeft = leftMAX - 60;
    }
    setState(() {
      top = newTop;
      left = newLeft;
    });
  }

  Future<void> setLandscape(BuildContext context) async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) {
            topMAX = MediaQuery.of(context).size.height - 90;
            leftMAX = MediaQuery.of(context).size.width;
            return const SizedBox.shrink();
          });
    });
  }

  Future<void> setPortrait() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Widget vlcControls(BuildContext context) {
    return Visibility(
        visible: _controlsVisible,
        child: SizedBox(
          height: deviceSizePortrait.height,
          width: deviceSizePortrait.width,
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.fast_rewind_outlined,
                          size: 45,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                            setState(() {
                              _visible = false;
                              _iconData = Icons.play_arrow;
                            });
                          } else {
                            _controller.play();
                            setState(() {
                              _visible = true;
                              _iconData = Icons.pause;
                            });
                          }
                          setState(() {
                            _controlsVisible = true;
                          });
                        },
                        icon: Icon(
                          _iconData,
                          size: 50,
                          color: kRed,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.fast_forward_outlined,
                          size: 45,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0, left: 4, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${format(_controller.value.position)}/${format(_controller.value.duration)}",
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 14,
                      ),
                    ),
                    kHeight5,
                    VideoProgressIndicator(_controller, allowScrubbing: true,colors: const VideoProgressColors(bufferedColor: kBlue)),
                    kHeight5
                  ],
                ),
              )
            ],
          ),
        ));
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void initState() {
    setLandscape(context);
    _controller = VideoPlayerController.network(
      widget.link,
    )..initialize().then((value) {
        _controller.play();
      });
    _controller.addListener(() async {
      if (_controller.value.isInitialized) {
        if (_controller.value.position.compareTo(_controller.value.duration) ==
            0) {
          print('Video ended, popping...');
          await setPortrait();
          if (context.mounted) {
            Navigator.of(context).pop(); // on finish video
          }
        }

        if (timer != null) {
          if (!_controller.value.isPlaying) {
            print('Timer cancel');
            timer!.cancel();
          } else {
            if (!timer!.isActive) {
              timer = Timer.periodic(
                  const Duration(seconds: 5), (Timer t) => updateLocation());
              print('Timer started');
            }
          }
        } else {
          if (_controller.value.isPlaying) {
            print('Timer running');
            timer = Timer.periodic(
                const Duration(seconds: 5), (Timer t) => updateLocation());
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            color: deviceDarkThemeFlag ? kBlack : kWhite,
            height: deviceSizePortrait.height,
            width: deviceSizePortrait.width,
            child: const Loading())
        : GestureDetector(
            onTap: () {
              if (_controlsVisible) {
                setState(() {
                  _controlsVisible = false;
                });
              } else {
                setState(() {
                  _controlsVisible = true;
                });
                Future.delayed(const Duration(seconds: 6), () {
                  setState(() {
                    _controlsVisible = false;
                  });
                });
              }
            },
            child: Scaffold(
              body: WillPopScope(
                onWillPop: () async {
                  await setPortrait();
                  return false;
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    VideoPlayer(_controller),
                    Visibility(
                      visible: _visible,
                      child: Positioned(
                        top: top,
                        left: left,
                        child: Container(
                          color: kRed,
                          height: 30,
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            widget.watermark,
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.white30, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: vlcControls(context),
                        )),
                  ],
                ),
              ),
            ),
          );
  }
}
