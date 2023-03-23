import 'dart:convert';

import 'package:credstream/core/values.dart';
import 'package:credstream/models/credential.dart';
import 'package:credstream/models/user.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<bool> signupUser(User user) async {
    try {
      http.Response response = await http.post(Uri.parse('$baseUrl/register'),
          headers: header, body: jsonEncode(User.toJson(user)));

      if (response.statusCode == succescodeUserPOST) {
        return true;
      }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  static Future<Credential?> loginUser(User user) async {
    try {
      http.Response response = await http.post(Uri.parse('$baseUrl/login'),
          headers: header, body: jsonEncode(User.toJson(user)));
      if (response.statusCode == successcode) {
        // return response.body;
        // parse json
        final data = jsonDecode(response.body); 
        return Credential(
            credential: data['cred'], message: data['message'], name: data['name']);
      }
    } on Exception catch (e) {
      print(e);
    }

    return null;
  }
}
