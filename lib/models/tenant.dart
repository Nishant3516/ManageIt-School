class Tenant {
  final int id;
  final String? tenantName;
  final String? tenantLogo;
  final String? tenantLogoContentType;
  final String? createDate;
  final String? lastModified;
  final String? cancelDate;
  final dynamic questions;
  final dynamic questionTypes;
  final dynamic questionPapers;
  final dynamic tags;

  Tenant({
    required this.id,
    required this.tenantName,
    this.tenantLogo,
    this.tenantLogoContentType,
    this.createDate,
    this.lastModified,
    this.cancelDate,
    this.questions,
    this.questionTypes,
    this.questionPapers,
    this.tags,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: json['id'],
      tenantName: json['tenantName'],
      tenantLogo: json['tenantLogo'],
      tenantLogoContentType: json['tenantLogoContentType'],
      createDate: json['createDate'],
      lastModified: json['lastModified'],
      cancelDate: json['cancelDate'],
      questions: json['questions'],
      questionTypes: json['questionTypes'],
      questionPapers: json['questionPapers'],
      tags: json['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenantName': tenantName,
      'tenantLogo': tenantLogo,
      'tenantLogoContentType': tenantLogoContentType,
      'createDate': createDate,
      'lastModified': lastModified,
      'cancelDate': cancelDate,
      'questions': questions,
      'questionTypes': questionTypes,
      'questionPapers': questionPapers,
      'tags': tags,
    };
  }
}
