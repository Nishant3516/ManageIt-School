import 'dart:typed_data';
import 'package:manageit_school/models/class.dart';

class Student {
  final int? id;
  final Uint8List? studentPhoto;
  final String? studentPhotoContentType;
  final String? studentPhotoLink;
  final String firstName;
  final String? gender;
  final String? lastName;
  final String? rollNumber;
  final String? phoneNumber;
  final String? bloodGroup;
  final String? dateOfBirth;
  final String? startDate;
  final String? addressLine1;
  final String? addressLine2;
  final String? nickName;
  final String? fatherName;
  final String? motherName;
  final String? email;
  final String? admissionDate;
  final String? regNumber;
  final String? endDate;
  final String? createDate;
  final String? lastModified;
  final String? cancelDate;
  final Class schoolClass;
  final dynamic studentDiscounts;
  final dynamic studentAdditionalCharges;
  final dynamic studentChargesSummaries;
  final dynamic studentPayments;
  final dynamic studentAttendences;
  final dynamic studentHomeWorkTracks;
  final dynamic studentClassWorkTracks;

  Student({
    required this.firstName,
    required this.schoolClass,
    this.startDate,
    this.phoneNumber,
    this.fatherName,
    this.lastName,
    this.addressLine1,
    this.rollNumber,
    this.id,
    this.gender,
    this.studentPhoto,
    this.studentPhotoContentType,
    this.studentPhotoLink,
    this.bloodGroup,
    this.dateOfBirth,
    this.addressLine2,
    this.nickName,
    this.motherName,
    this.email,
    this.admissionDate,
    this.regNumber,
    this.endDate,
    this.createDate,
    this.lastModified,
    this.cancelDate,
    this.studentDiscounts,
    this.studentAdditionalCharges,
    this.studentChargesSummaries,
    this.studentPayments,
    this.studentAttendences,
    this.studentHomeWorkTracks,
    this.studentClassWorkTracks,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'rollNumber': rollNumber,
      'phoneNumber': phoneNumber,
      'addressLine1': addressLine1,
      'fatherName': fatherName,
      'gender': gender,
      'startDate': startDate, // Convert DateTime to String
      'schoolClass': schoolClass.toJson(), // Convert Class to JSON
      // ... include other fields as needed
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      studentPhoto: json['studentPhoto'],
      studentPhotoContentType: json['studentPhotoContentType'],
      studentPhotoLink: json['studentPhotoLink'],
      // studentId: json['studentId'],
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
      rollNumber: json['rollNumber'],
      phoneNumber: json['phoneNumber'],
      bloodGroup: json['bloodGroup'],
      dateOfBirth: json['dateOfBirth'],
      startDate: json['startDate'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      nickName: json['nickName'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      email: json['email'],
      admissionDate: json['admissionDate'],
      regNumber: json['regNumber'],
      endDate: json['endDate'],
      createDate: json['createDate'],
      lastModified: json['lastModified'],
      cancelDate: json['cancelDate'],
      studentDiscounts: json['studentDiscounts'],
      studentAdditionalCharges: json['studentAdditionalCharges'],
      studentChargesSummaries: json['studentChargesSummaries'],
      studentPayments: json['studentPayments'],
      studentAttendences: json['studentAttendences'],
      studentHomeWorkTracks: json['studentHomeWorkTracks'],
      studentClassWorkTracks: json['studentClassWorkTracks'],
      schoolClass: Class.fromJson(json['schoolClass']),
    );
  }
}
