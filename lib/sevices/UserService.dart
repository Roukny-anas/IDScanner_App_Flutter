import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  final String baseUrl = "http://192.168.1.38:8081/api/users";

  // Get all users
  Future<List<User>> getAllUsers() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users: ${response.body}');
    }
  }

  // Get user by ID
  Future<User> getUserById(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user by ID: ${response.body}');
    }
  }

  // Get user by email
  Future<User?> getUserByEmail(String email) async {
    final url = Uri.parse('$baseUrl/search?email=$email');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Update user
  Future<User> updateUser(int id, User user) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user: ${response.body}');
    }
  }

  // Delete user
  Future<void> deleteUser(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user: ${response.body}');
    }
  }
}
