import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/models/video.dart';
import 'package:credstream/player/landscape_player.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final Video videomodel;
  const VideoPlayer({super.key, required this.videomodel});
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late String _watermark = '';
  bool overlayVisible = true;
  bool _loading = false;

  _VideoPlayerState();

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  void initState() {
    _watermark = LocalDBCrud.currentUser().credentialWatermark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(
        child: SizedBox(
          height: deviceSizePortrait.height, 
          width: deviceSizePortrait.width,
          child: Stack( 
            children: [ 
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight20,
                    videoOverlay(),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kHeight20,
                          Text(
                            widget.videomodel.name.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: kBlue),
                          ),
                          kHeight5,
                          Text(
                            "${widget.videomodel.ownership}: ${widget.videomodel.year.toString()}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          kHeight,
                          SizedBox(
                            height: 45,
                            child: Card(
                                color: kGreen, 
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Text(
                                    widget.videomodel.genre,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )),
                          ),
                          kHeight5, 
                          Text(
                            widget.videomodel.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ], 
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: _loading,
                  child: Container(
                      color: deviceDarkThemeFlag ? kBlack : kWhite,
                      height: deviceSizePortrait.height,
                      width: deviceSizePortrait.width,
                      child: const Loading()))
            ],
          ),
        ),
      ),
    );
  }

  Widget videoOverlay() {
    return Visibility(
      visible: overlayVisible,
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRect(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(widget.videomodel.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                )),
            IconButton(
              icon: const Icon(CupertinoIcons.play_rectangle_fill),
              iconSize: 40,
              color: Colors.red,
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                await playVideoFullScreen();
                setState(() {
                  _loading = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> playVideoFullScreen() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (cntxt) => LandScapePlayer(
              link: widget.videomodel.link,
              watermark: _watermark,
            )));
  }
}
