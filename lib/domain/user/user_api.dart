import 'dart:convert';

import 'package:credstream/core/values.dart';
import 'package:credstream/models/user.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<bool> postUser(User user) async {
    http.Response response = await http.post(Uri.parse(baseUrl),
        headers: header, body: jsonEncode(User.toJson(user)));

    if (response.statusCode == succesCodeUserPOST) {
      return true;
    }
    return false;
  }
}
