import 'dart:convert';

import 'package:drawer/data/services/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskService {
  Future<void> storeTask(Map<String, dynamic> taskData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/tasks'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(taskData),
      );

      if (response.statusCode != 201) {
        final data = jsonDecode(response.body);
        throw Exception(
            'Failed to store user: ${data['message'] ?? response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to store user: $e');
    }
  }
}
