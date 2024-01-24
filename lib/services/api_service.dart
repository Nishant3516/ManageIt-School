import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manageit_school/models/class.dart';
import 'package:manageit_school/models/student.dart';

class ApiService {
  static Future<List<Class>> fetchClasses(String token) async {
    const String apiUrl = "https://candeylabs.com/api/school-classes/";

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => Class.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String token) async {
    const String url = "https://candeylabs.com/api/account";
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<void> addStudent(String token, Student postData) async {
    const String apiUrl = "https://candeylabs.com/api/class-students";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(postData),
      );

      print(jsonEncode(postData));

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
