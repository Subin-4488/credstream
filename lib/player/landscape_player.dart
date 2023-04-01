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
  late int topMAX, leftMAX;

  late VlcPlayerController _controller;

  bool flag = false;
  bool _visible = false;

  Size? _videoSize;

  bool _loading = true;
  bool _exit = false;

  void updateLocation() {
    Random random = Random();
    top = random.nextInt(topMAX).toDouble();
    left = random.nextInt(leftMAX).toDouble();
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
          print("${_videoSize!.height} ${_videoSize!.width}");
          print(
              "Height: ${_controller.value.size.height}  Width: ${_controller.value.size.width}");
        });
      });
    }
  }

  Future<void> setLandscape() async {
    setState(() {
      _loading = true;
    });
    print('Making orientations');
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    topMAX = deviceSize.width.toInt(); //change it
    leftMAX = deviceSize.height.toInt(); //change it
    setLandscape();

    _controller = VlcPlayerController.network(
      widget.link,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );

    _controller.addListener(() async {
      if (_controller.value.isInitialized) {
        if (_loading) {
          stopLoading();
        }

        if (timer != null) {
          if (!_controller.value.isPlaying ||
              _controller.value.position == _controller.value.duration) {
            timer!.cancel();
            if (_controller.value.position == _controller.value.duration) {
              await setPortrait();
            }
          } else {
            if (!timer!.isActive && !_exit) {
              timer = Timer.periodic(
                  const Duration(seconds: 6), (Timer t) => updateLocation());
            }
          }
        } else {
          if (_controller.value.isPlaying) {
            timer = Timer.periodic(
                const Duration(seconds: 6), (Timer t) => updateLocation());
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
    timer!.cancel();
    setPortrait();
    super.dispose();
  }

  Future<void> setPortrait() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          setState(() {
            _loading = true;
          });
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
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height:
                    _videoSize != null ? _videoSize!.height : deviceSize.width,
                width:
                    _videoSize != null ? _videoSize!.width : deviceSize.height,
                child: VlcPlayer(
                    controller: _controller,
                    aspectRatio: _controller.value.aspectRatio,
                    placeholder: const Loading()),
              ),
            ),
            Visibility(
              visible: _visible,
              child: ValueListenableBuilder(
                  valueListenable: pixelNotifier,
                  builder: ((context, value, child) {
                    return Positioned(
                      top: top,
                      left: left,
                      child: Text(
                        widget.watermark,
                        style: const TextStyle(
                            color: Colors.white30, fontSize: 25),
                      ),
                    );
                  })),
            ),
            Visibility(
              visible: _loading,
              child: Container(
                  color: deviceDarkThemeFlag ? kBlack : kWhite,
                  height: deviceSize.height,
                  width: deviceSize.width,
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
