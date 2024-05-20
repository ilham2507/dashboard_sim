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

  Future<void> storeUser(
      Map<String, dynamic> userData, String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServices.baseUrl}/users'));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields
        .addAll(userData.map((key, value) => MapEntry(key, value.toString())));

    if (imagePath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('foto_profile', imagePath));
    }

    var response = await request.send();
    if (response.statusCode != 201) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      throw Exception(
          'Failed to store user: ${data['message'] ?? response.statusCode}');
    }
  }
}
