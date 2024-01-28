import 'package:manageit_school/models/tenant.dart';

class School {
  final int id;
  final String? groupName;
  final String? schoolName;
  final String? address;
  final String? afflNumber;
  final String? createDate;
  final String? lastModified;
  final String? cancelDate;
  final Tenant? tenant;

  School({
    required this.id,
    this.groupName,
    this.schoolName,
    this.address,
    this.afflNumber,
    this.createDate,
    this.lastModified,
    this.cancelDate,
    this.tenant,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      groupName: json['groupName'],
      schoolName: json['schoolName'],
      address: json['address'],
      afflNumber: json['afflNumber'],
      createDate: json['createDate'],
      lastModified: json['lastModified'],
      cancelDate: json['cancelDate'],
      tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'schoolName': schoolName,
      'address': address,
      'afflNumber': afflNumber,
      'createDate': createDate,
      'lastModified': lastModified,
      'cancelDate': cancelDate,
      'tenant': tenant != null ? tenant!.toJson() : null,
    };
  }
}
