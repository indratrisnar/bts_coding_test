import 'dart:convert';

import 'package:bts_coding_test/core/api.dart';
import 'package:bts_coding_test/core/log.dart';
import 'package:d_session/d_session.dart';
import 'package:http/http.dart' as http;

class ChecklistItemDatasource {
  static Future<(bool, List?)> fetchAll(int todoId) async {
    final url = '${Api.baseURL}/checklist/$todoId/item';
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
      fdLog.title('catch fetchAll ChecklistItem', e.toString());
      return (false, null);
    }
  }

  static Future<(bool, String)> add(
    int todoId,
    String itemName,
  ) async {
    final url = '${Api.baseURL}/checklist/$todoId/item';
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
          'itemName': itemName,
        }),
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        return (true, 'Add ChecklistItem Success');
      }
      return (false, 'Add ChecklistItem Failed');
    } catch (e) {
      fdLog.title('catch Add ChecklistItem', e.toString());
      return (false, 'Add ChecklistItem Failed');
    }
  }

  static Future<(bool, String)> delete(int todoId, int itemId) async {
    final url = '${Api.baseURL}/checklist/$todoId/item/$itemId';
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
        return (true, 'Delete ChecklistItem Success');
      }
      return (false, 'Delete ChecklistItem Failed');
    } catch (e) {
      fdLog.title('catch Delete ChecklistItem', e.toString());
      return (false, 'Delete ChecklistItem Failed');
    }
  }

  static Future<(bool, String)> updateStatus(int todoId, int itemId) async {
    final url = '${Api.baseURL}/checklist/$todoId/item/$itemId';
    try {
      final tokenData = await DSession.getToken();
      final token = tokenData!['token'];
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        return (true, 'Update Status ChecklistItem Success');
      }
      return (false, 'Update Status ChecklistItem Failed');
    } catch (e) {
      fdLog.title('catch Update Status ChecklistItem', e.toString());
      return (false, 'Update Status ChecklistItem Failed');
    }
  }

  static Future<(bool, String)> rename(
    int todoId,
    int itemId,
    String itemName,
  ) async {
    final url = '${Api.baseURL}/checklist/$todoId/item/rename/$itemId';
    try {
      final tokenData = await DSession.getToken();
      final token = tokenData!['token'];
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'itemName': itemName,
        }),
      );
      fdLog.response(response);
      if (response.statusCode == 200) {
        return (true, 'Rename ChecklistItem Success');
      }
      return (false, 'Rename ChecklistItem Failed');
    } catch (e) {
      fdLog.title('catch Rename ChecklistItem', e.toString());
      return (false, 'Rename ChecklistItem Failed');
    }
  }
}
