import 'package:manageit_school/models/models.dart';

class Payment {
  int? id;
  String? summaryType;
  String? feeYear;
  int? dueDate;
  String? aprSummary;
  String? maySummary;
  String? junSummary;
  String? julSummary;
  String? augSummary;
  String? sepSummary;
  String? octSummary;
  String? novSummary;
  String? decSummary;
  String? janSummary;
  String? febSummary;
  String? marSummary;
  String? additionalInfo1;
  String? additionalInfo2;
  DateTime? createDate;
  DateTime? lastModified;
  DateTime? cancelDate;
  dynamic schoolLedgerHead;
  Student? classStudent;

  Payment({
    this.id,
    this.summaryType,
    this.feeYear,
    this.dueDate,
    this.aprSummary,
    this.maySummary,
    this.junSummary,
    this.julSummary,
    this.augSummary,
    this.sepSummary,
    this.octSummary,
    this.novSummary,
    this.decSummary,
    this.janSummary,
    this.febSummary,
    this.marSummary,
    this.additionalInfo1,
    this.additionalInfo2,
    this.createDate,
    this.lastModified,
    this.cancelDate,
    this.schoolLedgerHead,
    this.classStudent,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      summaryType: json['summaryType'],
      feeYear: json['feeYear'],
      dueDate: json['dueDate'],
      aprSummary: json['aprSummary'],
      maySummary: json['maySummary'],
      junSummary: json['junSummary'],
      julSummary: json['julSummary'],
      augSummary: json['augSummary'],
      sepSummary: json['sepSummary'],
      octSummary: json['octSummary'],
      novSummary: json['novSummary'],
      decSummary: json['decSummary'],
      janSummary: json['janSummary'],
      febSummary: json['febSummary'],
      marSummary: json['marSummary'],
      additionalInfo1: json['additionalInfo1'],
      additionalInfo2: json['additionalInfo2'],
      createDate: json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : null,
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
      cancelDate: json['cancelDate'] != null
          ? DateTime.parse(json['cancelDate'])
          : null,
      schoolLedgerHead: json['schoolLedgerHead'],
      classStudent: json['classStudent'] != null
          ? Student.fromJson(json['classStudent'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'summaryType': summaryType,
      'feeYear': feeYear,
      'dueDate': dueDate,
      'aprSummary': aprSummary,
      'maySummary': maySummary,
      'junSummary': junSummary,
      'julSummary': julSummary,
      'augSummary': augSummary,
      'sepSummary': sepSummary,
      'octSummary': octSummary,
      'novSummary': novSummary,
      'decSummary': decSummary,
      'janSummary': janSummary,
      'febSummary': febSummary,
      'marSummary': marSummary,
      'additionalInfo1': additionalInfo1,
      'additionalInfo2': additionalInfo2,
      'createDate': createDate?.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),
      'cancelDate': cancelDate?.toIso8601String(),
      'schoolLedgerHead': schoolLedgerHead,
      'classStudent': classStudent?.toJson(),
    };
  }
}
