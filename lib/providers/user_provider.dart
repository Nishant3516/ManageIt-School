import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? _userDetails;
  String? _userToken;

  // Setter method to update user details
  void setUserDetails(Map<String, dynamic>? userDetails, String? userToken) {
    _userDetails = userDetails;
    _userToken = userToken;

    notifyListeners();
  }

  // Getter method to get user details
  Map<String, dynamic>? get userDetails => _userDetails;

  // Getter method to get user token
  String? get userToken => _userToken;

  // Method to check if the user is a student
  bool isUserStudent() {
    // Check if the user has only one role and it is 'ROLE_SCHOOL_STUDENT'
    final List<dynamic>? authorities = _userDetails?['authorities'];
    return authorities?.length == 1 &&
        authorities!.contains('ROLE_SCHOOL_STUDENT');
  }
}
