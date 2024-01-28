import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentService {
  Future<bool> addStudent(String token, Student postData) async {
    const String apiUrl = "https://candeylabs.com/api/class-students/";

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
        print("Successfully added");
        return true;
      } else {
        print("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("An error occurred: $e");
      return false;
    }
  }

  static Future<Student?> getStudentPaymentDetailsById(
      int id, String userToken) async {
    try {
      final String url =
          'https://candeylabs.com/api/student-charges-summaries?studentIds=$id&onlyDues=false';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $userToken'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return Student.fromJson(data[0]['classStudent']);
      } else {
        throw Exception('Failed to load student details');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Student?> getStudentDetailsById(
      int id, String userToken) async {
    try {
      final String url = 'https://candeylabs.com/api/class-students/$id';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $userToken'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Student.fromJson(data);
      } else {
        throw Exception('Failed to load student details');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<Student>?> getStudentsByClass(
      int classId, String userToken) async {
    final String url =
        'https://candeylabs.com/api/class-students?schoolClassId.equals=$classId';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $userToken'},
    );

    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> dataList = jsonDecode(response.body);
      return dataList.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<void> deleteStudentById(int studentId, String userToken) async {
    final String apiUrl =
        "https://candeylabs.com/api/class-students/$studentId";

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 204) {
        // Student deleted successfully
        print("Student with ID $studentId deleted successfully.");
      } else {
        // Failed to delete student
        print("Failed to delete student. Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      // An error occurred while making the request
      print("An error occurred: $e");
    }
  }

  Future<bool> updateStudentDetails(
      Student data, int studentId, String userToken) async {
    final String url = "https://candeylabs.com/api/class-students/$studentId";
    print(jsonEncode(data.toJson()));
    try {
      // Make the API call
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(data.toJson()),
      );
      print(response.body);
      print(response.statusCode);
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Data updated successfully');
        return true;
      } else {
        print('Error updating data: ${response.statusCode}');
        print('Error updating data: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
