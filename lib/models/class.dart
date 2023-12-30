import 'package:manageit_school/models/school.dart';

class Class {
  final int id;
  final String className;
  final String classLongName;
  final String? createDate;
  final String? lastModified;
  final String? cancelDate;
  final School? school; // Make the school field nullable
  final dynamic classStudents;
  final dynamic classLessionPlans;
  final dynamic schoolNotifications;
  final dynamic classFees;
  final dynamic classSubjects;
  final dynamic schoolUsers;
  final dynamic schoolDaysOffs;
  final dynamic schoolEvents;
  final dynamic schoolPictureGalleries;
  final dynamic vchoolVideoGalleries;
  final dynamic schoolReports;

  Class({
    required this.id,
    required this.className,
    required this.classLongName,
    required this.school,
    this.createDate,
    this.lastModified,
    this.cancelDate,
    this.classStudents,
    this.classLessionPlans,
    this.schoolNotifications,
    this.classFees,
    this.classSubjects,
    this.schoolUsers,
    this.schoolDaysOffs,
    this.schoolEvents,
    this.schoolPictureGalleries,
    this.vchoolVideoGalleries,
    this.schoolReports,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      className: json['className'],
      classLongName: json['classLongName'],
      createDate: json['createDate'],
      lastModified: json['lastModified'],
      cancelDate: json['cancelDate'],
      classStudents: json['classStudents'],
      classLessionPlans: json['classLessionPlans'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      schoolNotifications: json['schoolNotifications'],
      classFees: json['classFees'],
      classSubjects: json['classSubjects'],
      schoolUsers: json['schoolUsers'],
      schoolDaysOffs: json['schoolDaysOffs'],
      schoolEvents: json['schoolEvents'],
      schoolPictureGalleries: json['schoolPictureGalleries'],
      vchoolVideoGalleries: json['vchoolVideoGalleries'],
      schoolReports: json['schoolReports'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'classLongName': classLongName,
      'createDate': createDate,
      'lastModified': lastModified,
      'cancelDate': cancelDate,
      'classStudents': classStudents,
      'classLessionPlans': classLessionPlans,
      'school': school?.toJson(), // Convert School to JSON if not null
      'schoolNotifications': schoolNotifications,
      'classFees': classFees,
      'classSubjects': classSubjects,
      'schoolUsers': schoolUsers,
      'schoolDaysOffs': schoolDaysOffs,
      'schoolEvents': schoolEvents,
      'schoolPictureGalleries': schoolPictureGalleries,
      'vchoolVideoGalleries': vchoolVideoGalleries,
      'schoolReports': schoolReports,
    };
  }
}
