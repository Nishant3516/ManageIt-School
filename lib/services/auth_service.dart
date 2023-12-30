import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://ssik.in/api/';

  Future<String?> authenticate(
      String username, String password, bool rememberMe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authenticate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'rememberMe': rememberMe,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful login (parse response if needed)
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String idToken = jsonResponse['id_token'];

      // Use the idToken as needed (e.g., store it in secure storage)
      print('Login successful! JWT Token: $idToken');

      return idToken;
    } else {
      // Handle login failure (parse error message if needed)
      print('Login failed. Status code: ${response.statusCode}');
      return null;
    }
  }

  Future<bool> register(String login, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'login': login,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Handle successful registration (parse response if needed)
      return true;
    } else {
      // Handle registration failure (parse error message if needed)
      print('Registration failed. Status code: ${response.statusCode}');
      return false;
    }
  }
}
