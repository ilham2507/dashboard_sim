import 'dart:convert';

import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/services/api/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProyekServices {
  Future<List<Proyek>> getProyek() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/proyeks'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['proyek'];
        print(responseData);
        return responseData.map((json) => Proyek.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<Proyek> getProyekById(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/proyeks/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['proyek'];
        print(responseData);
        return Proyek.fromJson(responseData);
      } else {
        print('Failed to load proyek: ${response.statusCode}');
        throw Exception('Failed to load proyek: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load proyek: $e');
      throw Exception('Failed to load proyek: $e');
    }
  }

  Future<void> storeProyek(Map<String, dynamic> proyekData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/proyeks'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(proyekData),
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

  Future<void> updateProyekById(
      String proyekId, Map<String, dynamic> proyekData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    try {
      final url = Uri.parse('${ApiServices.baseUrl}/proyeks/$proyekId');
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
}
