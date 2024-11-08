import 'dart:convert';

import 'package:bts_coding_test/core/log.dart';
import 'package:d_session/d_session.dart';
import 'package:http/http.dart' as http;

import '../core/api.dart';

class AuthDataSource {
  static Future<(bool, String)> login(String username, String password) async {
    const url = '${Api.baseURL}/login';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        Map data = resBody['data'];
        DSession.setToken(Map.from(data));
        return (true, 'Login Success');
      }
      return (false, 'Login Failed');
    } catch (e) {
      fdLog.title('catch login', e.toString());
      return (false, 'Login Failed');
    }
  }

  static Future<(bool, String)> register(
    String username,
    String email,
    String password,
  ) async {
    const url = '${Api.baseURL}/register';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'email': email,
          'username': username,
          'password': password,
        }),
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        return (true, 'Register Success');
      }
      return (false, 'Register Failed');
    } catch (e) {
      fdLog.title('catch Register', e.toString());
      return (false, 'Register Failed');
    }
  }
}
