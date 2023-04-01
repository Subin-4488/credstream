import 'package:credstream/core/values.dart';
import 'package:credstream/models/video.dart';
import 'package:credstream/core/constants.dart';
import 'package:http/http.dart' as http;

class VideoApi {
  static Future<Map<String, List<Video>>> populateVideos() async {
    Map<String, List<Video>> map = {};
    for (int i = 0; i < genres.length; i++) {
      http.Response response =
          await http.get(Uri.parse("$baseUrl/videos/genre/${genres[i]}"));
      if (response.statusCode == 200) {
        map.addAll({genres[i]: Video.fromJson(response.body)});
      }
    }
    map.forEach((key, value) {
      print("$key: ");
      value.forEach((element) {
        print(element.name);
      });
    });
    return map;
  }
}
