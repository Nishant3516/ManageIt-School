import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manageit_school/constants/constants.dart';
import 'package:manageit_school/models/payment.dart';

const String token = Constants.token;

class PaymentService {
  Future<List<Payment>> getPaymentDetailsByID(int studentId) async {
    try {
      final url =
          "https://candeylabs.com/api/student-charges-summaries?studentIds=$studentId&onlyDues=false";
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> resultList = json.decode(response.body);
        final List<Payment> payments = resultList
            .map((paymentJson) => Payment.fromJson(paymentJson))
            .toList();
        print(payments);
        return payments;
      } else {
        print('Failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
