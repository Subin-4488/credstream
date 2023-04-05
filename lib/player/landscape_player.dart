import 'dart:async';
import 'dart:math';

import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class LandScapePlayer extends StatefulWidget {
  final String watermark;
  final String link;

  const LandScapePlayer(
      {required this.link, required this.watermark, super.key});

  @override
  State<LandScapePlayer> createState() => _LandScapePlayerState();
}

class _LandScapePlayerState extends State<LandScapePlayer> with ChangeNotifier {
  Timer? timer;
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  ValueNotifier<int> pixelNotifier = ValueNotifier(0);
  double top = 0, left = 0;
  late double topMAX, leftMAX;

  late VlcPlayerController _controller;

  bool flag = false;
  bool _visible = false;

  bool _controlsVisible = true;

  bool _loading = true;
  bool _exit = false;

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
    pixelNotifier.value += 1;
    pixelNotifier.notifyListeners();
  }

  void stopLoading() {
    if (_loading) {
      _controller.play();
      Future.delayed(const Duration(seconds: 1), () {
        _controller.pause();
        _controller.seekTo(Duration.zero);
        setState(() {
          _loading = false;
        });
      });
    }
  }

  Future<void> setLandscape() async {
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

  @override
  void initState() {
    setState(() {
      _loading = true;
    });

    setLandscape();
    _controller = VlcPlayerController.network(
      widget.link,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );

    setState(() {
      _loading = false;
    });

    // _controller.play(); 
    // Future.delayed(const Duration(seconds: 3), () {
    //   _controller.pause();
    //   _controller.seekTo(Duration.zero);
    // });

    _controller.addListener(() async {
      if (_controller.value.isInitialized) {
        if (_loading) {
          stopLoading();
        }

        if (_controller.value.isEnded) {
          await pop(); // on finish video
        }

        if (timer != null) {
          if (!_controller.value.isPlaying ||
              _controller.value.position == _controller.value.duration) {
            timer!.cancel();
          } else {
            if (!timer!.isActive && !_exit) {
              timer = Timer.periodic(
                  const Duration(seconds: 5), (Timer t) => updateLocation());
            }
          }
        } else {
          if (_controller.value.isPlaying) {
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
    pixelNotifier.dispose();
    valueNotifier.dispose();
    Future.wait([_controller.stopRendererScanning(), _controller.dispose()]);
    _exit = true;
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            await pop();
            return false;
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              VlcPlayer(
                  controller: _controller,
                  aspectRatio: _controller.value.aspectRatio,
                  placeholder: const Loading()),
              Visibility(
                visible: _visible,
                child: ValueListenableBuilder(
                    valueListenable: pixelNotifier,
                    builder: ((context, value, child) {
                      return Positioned(
                        top: top,
                        left: left,
                        child: Container(
                          // color: kRed,
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
                      );
                    })),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: vlcControls(context),
                  )),
              Visibility(
                visible: _loading,
                child: Container(
                    color: deviceDarkThemeFlag ? kBlack : kWhite,
                    height: deviceSizePortrait.height,
                    width: deviceSizePortrait.width,
                    child: const Loading()),
              )
            ],
          ),
        ),
      ),
    );
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
                          });
                        } else {
                          _controller.play();
                          setState(() {
                            _visible = true;
                          });
                        }
                        flag = !flag;
                        valueNotifier.notifyListeners();
                      },
                      icon: ValueListenableBuilder(
                        valueListenable: valueNotifier,
                        builder: (context, value, child) {
                          return Icon(
                            flag ? Icons.play_arrow_outlined : Icons.pause,
                            size: 50,
                            color: kRed,
                          );
                        },
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
                  LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: kGrey400,
                    color: kRed,
                    value: _controller.value.isInitialized
                        ? _controller.value.position.inSeconds /
                            _controller.value.duration.inSeconds
                        : 0,
                  ),
                  kHeight5
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  Future<void> pop() async {
    setState(() {
      _loading = true;
    });
    await setPortrait();
    setState(() {
      _loading = false;
    });
    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
