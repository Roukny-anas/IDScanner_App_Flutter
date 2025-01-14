import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_request.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = "http://192.168.1.37:8081/api/auth";

  // Sign Up
  Future<String> signUp(User user) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  // Sign In
  Future<String> signIn(AuthRequest authRequest) async {
    final url = Uri.parse('$baseUrl/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(authRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign in: ${response.body}');
    }
  }

  // Enable 2FA
  Future<String> enableTwoFactorAuth(String email) async {
    final url = Uri.parse('$baseUrl/enable-2fa?email=$email');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to enable 2FA: ${response.body}');
    }
  }

  // Verify 2FA
  Future<String> verifyTwoFactorAuth(AuthRequest authRequest) async {
    final url = Uri.parse('$baseUrl/verify-2fa');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(authRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to verify 2FA: ${response.body}');
    }
  }

  // Check if 2FA is enabled for a user
  Future<bool> isTwoFactorAuthEnabled(String email) async {
    final url = Uri.parse('$baseUrl/check-2fa?email=$email');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['is2FAEnabled'] ?? false;
    } else {
      throw Exception('Failed to check 2FA status: ${response.body}');
    }
  }
}