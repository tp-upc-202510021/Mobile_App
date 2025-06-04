import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }
}
