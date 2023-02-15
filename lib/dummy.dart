import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  // String video =
  //     'https://joy1.videvo.net/videvo_files/video/free/2019-09/large_watermarked/190828_27_SuperTrees_HD_17_preview.mp4';
  String video = 'asset/videos/result.mkv';
  bool flag = false;
  late VideoPlayerController _controller;
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  String watermark = 'SD001';

  ValueNotifier<int> pixelNotifier = ValueNotifier(0);

  double top = 0, left = 0;
  late int topMAX, leftMAX;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(video)
      ..initialize().then((value) {
        setState(() {
          print(_controller.value.size.height);
          print(_controller.value.size.width);
          topMAX = (_controller.value.size.height - 100).toInt();
          leftMAX = (_controller.value.size.width - 100).toInt();
        });
      });
    _controller.addListener(() {
      if (timer != null) {
        if (!_controller.value.isPlaying || _controller.value.position == _controller.value.duration) {
          timer!.cancel();
        } else {
          if (!timer!.isActive) {
            timer = Timer.periodic(
                const Duration(seconds: 3), (Timer t) => updateLocation());
          }
        }
      } else {
        if (_controller.value.isPlaying) {
          timer = Timer.periodic(
              const Duration(seconds: 3), (Timer t) => updateLocation());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
    _controller.dispose();
  }

  void updateLocation() {
    Random random = Random();
    top = random.nextInt(topMAX).toDouble();
    left = random.nextInt(leftMAX).toDouble();
    pixelNotifier.value += 1;
    pixelNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              child: _controller.value.isInitialized
                  ? Column(
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Stack(children: [
                            VideoPlayer(_controller),
                            ValueListenableBuilder(
                                valueListenable: pixelNotifier,
                                builder: ((context, value, child) {
                                  return Positioned(
                                    top: top,
                                    left: left,
                                    child: Text(
                                      watermark,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }))
                          ]),
                        ),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true)
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
            flag = !flag;
            valueNotifier.notifyListeners();
          }),
          child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return Icon(flag ? Icons.pause : Icons.play_arrow);
            },
          ),
        ));
  }
}
