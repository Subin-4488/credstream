import 'dart:convert';

import 'package:credstream/core/values.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';

class Video {
  final String image;
  final String name;
  final String description;
  final int year;
  final String genre;

  final String link;
  final String ownership;

  Video(
      {required this.link,
      required this.genre,
      required this.year,
      required this.image,
      required this.name,
      required this.description,
      required this.ownership});

  static List<Video> fromJson(String data) {
    List<Video> ret = [];
    List<dynamic> list = jsonDecode(data);
    for (var e in list) {
      ret.add(Video(
          // link: "$baseUrl/static/videos/${e['title']}.m3u8",
          link:
              "$baseUrl/${LocalDBCrud.currentUser().credentialWatermark}/${e['title']}.m3u8",
          genre: e['genre'],
          year: e['release_year'],
          image: "$baseUrl/thumbnail/${e['title']}.jpg",
          name: e['title'],
          description: e['bio'],
          ownership: e['ownership']));
    }
    return ret;
  }
}
