import 'dart:convert';

import 'package:bts_coding_test/core/api.dart';
import 'package:bts_coding_test/core/log.dart';
import 'package:d_session/d_session.dart';
import 'package:http/http.dart' as http;

class TodoDatasource {
  static Future<(bool, List?)> fetchAll() async {
    const url = '${Api.baseURL}/checklist';
    try {
      final tokenData = await DSession.getToken();
      final token = tokenData!['token'];
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final data = resBody['data'];
        return (true, List.from(data));
      }

      return (false, null);
    } catch (e) {
      fdLog.title('catch fetchAll Todo', e.toString());
      return (false, null);
    }
  }

  static Future<(bool, String)> add(String name) async {
    const url = '${Api.baseURL}/checklist';
    try {
      final tokenData = await DSession.getToken();
      final token = tokenData!['token'];
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
        }),
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        return (true, 'Add Todo Success');
      }
      return (false, 'Add Todo Failed');
    } catch (e) {
      fdLog.title('catch Add Todo', e.toString());
      return (false, 'Add Todo Failed');
    }
  }

  static Future<(bool, String)> delete(int id) async {
    final url = '${Api.baseURL}/checklist/$id';
    try {
      final tokenData = await DSession.getToken();
      final token = tokenData!['token'];
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        return (true, 'Delete Todo Success');
      }
      return (false, 'Delete Todo Failed');
    } catch (e) {
      fdLog.title('catch Delete Todo', e.toString());
      return (false, 'Delete Todo Failed');
    }
  }
}
