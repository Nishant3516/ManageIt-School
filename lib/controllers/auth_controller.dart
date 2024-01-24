import 'package:manageit_school/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController {
  Future<String?> getUserToken(String username, String password) async {
    try {
      const url = "https://candeylabs.com/api/authenticate";
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final Map result = json.decode(response.body);
        final String token = result["id_token"];
        return token;
      }
      return '';
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> fetchAndStoreUserDetails(String token) async {
    try {
      final userDetails = await ApiService().fetchUserDetails(token);

      // Store token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      // Store user details in SharedPreferences\
      prefs.setString('userDetails', json.encode(userDetails));
    } catch (e) {
      // print("Error occured: $e");
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String token) async {
    try {
      final userDetails = await ApiService().fetchUserDetails(token);
      if (userDetails != null) {
        return userDetails;
      }
      return null;
    } catch (e) {
      // print("Error occured: $e");
    }
    return null;
  }

  Future<void> storeUserDetails(userDetails) async {
    try {
      // Store user details in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userDetails', json.encode(userDetails));
    } catch (e) {
      // print("Error occured: $e");
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetailsfromSP() async {
    // Get the stored user details from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? userDetailsJson = prefs.getString('userDetails');

    if (userDetailsJson != null) {
      final Map<String, dynamic> userDetails =
          Map<String, dynamic>.from(json.decode(userDetailsJson));

      return userDetails;
    } else {
      return null;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> registerUser(
      String username, String password, String email) async {
    try {
      const url = "https://candeylabs.com/api/register";
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "login": username,
          "password": password,
          "email": email,
        }),
      );
      if (response.statusCode == 201) {
        // print("Usere Created");
      }
    } catch (e) {
      // print(e);
    }
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userDetails');
  }
}
