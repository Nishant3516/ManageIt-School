import 'package:manageit_school/models/class.dart';
import 'package:manageit_school/services/api_service.dart';

class DataController {
  List<Class> classDataList = [];

  Future<void> fetchData() async {
    try {
      classDataList = await ApiService.fetchClasses();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
