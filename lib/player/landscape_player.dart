import 'dart:async';
import 'dart:math';

import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class LandScapePlayer extends StatefulWidget {
  String watermark;
  final String link;

  LandScapePlayer({required this.link, required this.watermark, super.key});

  @override
  State<LandScapePlayer> createState() => _LandScapePlayerState();
}

class _LandScapePlayerState extends State<LandScapePlayer> {
  Timer? timer;
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  ValueNotifier<int> pixelNotifier = ValueNotifier(0);
  double top = 0, left = 0;
  late double topMAX, leftMAX;

  late VlcPlayerController _controller;

  bool flag = false;
  bool _visible = false;

  Size? _videoSize;

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
          _videoSize = _controller.value.size;
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
            topMAX = MediaQuery.of(context).size.height;
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

    _controller.addListener(() async {
      if (_controller.value.isInitialized) {
        if (_loading) {
          stopLoading();
        }

        if (_controller.value.isEnded) {
              await setPortrait(); // on finish video
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            }

        if (timer != null) {
          if (!_controller.value.isPlaying ||
            _controller.value.position == _controller.value.duration) {
            timer!.cancel();
          } else {
            if (!timer!.isActive && !_exit) {
              timer = Timer.periodic(
                  const Duration(seconds: 1), (Timer t) => updateLocation());
            }
          }
        } else {
          if (_controller.value.isPlaying) {
            timer = Timer.periodic(
                const Duration(seconds: 1), (Timer t) => updateLocation());
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
    _controller.stopRendererScanning();
    _controller.dispose();
    _exit = true;
    if (timer != null) {
      timer!.cancel();
    }
    setPortrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
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
                    );
                  })),
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
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
        }),
        child: ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) {
            return Icon(flag ? Icons.pause : Icons.play_arrow);
          },
        ),
      ),
    );
  }
}
