import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String token = Constants.token;

class StudentService {
  static Future<Student?> getStudentById(int id) async {
    try {
      final String url =
          'https://candeylabs.com/api/student-charges-summaries?studentIds=$id&onlyDues=false';
      final response = await http.get(
        Uri.parse(
          url,
        ),
        headers: {'Authorization': 'Bearer $token'},
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

  static Future<List<Student>?> getStudentsByClass(int classId) async {
    final String url =
        'https://candeylabs.com/api/class-students?schoolClassId.equals=$classId';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = jsonDecode(response.body);
      return dataList.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }
}
