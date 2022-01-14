// To parse this JSON data, do
//
//     final audit = auditFromJson(jsonString);

import 'dart:convert';

List<Audit> auditFromJson(String str) =>
    List<Audit>.from(json.decode(str).map((x) => Audit.fromJson(x)));

class Audit {
  Audit({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    required this.data,
  });

  int? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<AuditData> data;

  factory Audit.fromJson(Map<String, dynamic> json) => Audit(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        data: List<AuditData>.from(
            json["Data"].map((x) => AuditData.fromJson(x))),
      );
}

class AuditData {
  AuditData({
    this.auditItems,
    required this.auditId,
    this.tagId,
    this.auditCode,
    required this.auditStartDate,
    required this.auditEndDate,
    required this.auditUserId,
    required this.auditUser,
    required this.auditStatus,
    this.auditRemarks,
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
  });

  dynamic auditItems;
  int auditId;
  int? tagId;
  String? auditCode;
  DateTime auditStartDate;
  DateTime auditEndDate;
  int auditUserId;
  String auditUser;
  String auditStatus;
  String? auditRemarks;
  int? responseCode;
  dynamic responseStatus;
  dynamic responseMessage;

  factory AuditData.fromJson(Map<String, dynamic> json) => AuditData(
        auditItems: json["AuditItems"],
        auditId: json["AuditID"],
        tagId: json["TagID"],
        auditCode: json["AuditCode"],
        auditStartDate: DateTime.parse(json["AuditStartDate"]),
        auditEndDate: DateTime.parse(json["AuditEndDate"]),
        auditUserId: json["AuditUserId"],
        auditUser: json["AuditUser"],
        auditStatus: json["AuditStatus"],
        auditRemarks: json["AuditRemarks"],
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
      );
}
