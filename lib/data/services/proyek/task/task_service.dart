import 'dart:convert';

import 'package:drawer/data/model/task_proyek.dart';
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

  Future<void> updateTaskById(
      String proyekId, Map<String, dynamic> proyekData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final url = Uri.parse('${ApiServices.baseUrl}/tasks/$proyekId');
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode(proyekData);

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode != 200) {
        final data = jsonDecode(response.body);
        print(
            'Failed to update proyek: ${data['message'] ?? response.statusCode}');
        throw Exception(
            'Failed to update proyek: ${data['message'] ?? response.statusCode}');
      }
    } catch (e) {
      print('Failed to update proyek: $e');
      throw Exception('Failed to update proyek: $e');
    }
  }

  Future<void> deleteTasksById(String proyekId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final url = Uri.parse('${ApiServices.baseUrl}/tasks/$proyekId');
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode != 200) {
        final data = jsonDecode(response.body);
        print(
            'Failed to delete proyek: ${data['message'] ?? response.statusCode}');
        throw Exception(
            'Failed to delete proyek: ${data['message'] ?? response.statusCode}');
      }
    } catch (e) {
      print('Failed to delete proyek: $e');
      throw Exception('Failed to delete proyek: $e');
    }
  }

  Future<TaskProyek> getTaskById(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/tasks/$taskId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['task'];
        print(responseData);
        return TaskProyek.fromJson(responseData);
      } else {
        print('Failed to load proyek: ${response.statusCode}');
        throw Exception('Failed to load proyek: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load proyek: $e');
      throw Exception('Failed to load proyek: $e');
    }
  }
}
