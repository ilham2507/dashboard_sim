import 'package:drawer/data/model/user.dart';
import 'package:drawer/data/services/api/api_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/users'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['users'];
        print(responseData);
        return responseData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<void> storeUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/users'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
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

  Future<User> getUserById(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/users/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['user'];
        print(responseData);
        return User.fromJson(responseData);
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<void> updateUserById(
      String userId, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final url = Uri.parse('${ApiServices.baseUrl}/users/$userId');
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode(userData);

      print('URL: $url');
      print('Headers: $headers');
      print('Body: $body');

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        final data = jsonDecode(response.body);
        print(
            'Failed to update user: ${data['message'] ?? response.statusCode}');
        throw Exception(
            'Failed to update user: ${data['message'] ?? response.statusCode}');
      }
    } catch (e) {
      print('Failed to update user: $e');
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteUserById(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final url = Uri.parse('${ApiServices.baseUrl}/users/$userId');
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
}
