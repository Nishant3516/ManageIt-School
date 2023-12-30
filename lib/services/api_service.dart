import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/models/class.dart';
import 'package:manageit_school/models/student.dart';

const String token = Constants.token;

class ApiService {
  static Future<List<Class>> fetchClasses() async {
    const String apiUrl = "https://candeylabs.com/api/school-classes";

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

  static Future<void> addStudent(Student postData) async {
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

      if (response.statusCode == 201) {
        print(response.body);
      } else {
        print("Failed to load data. Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('Failed to load data');
    }
  }
}
