// To parse this JSON data, do
//
//     final audit = auditFromJson(jsonString);

import 'dart:convert';

AuditAsset auditFromJson(String str) => AuditAsset.fromJson(json.decode(str));

class AuditAsset {
  AuditAsset(
      {required this.data,
      this.responseCode,
      required this.responseStatus,
      this.responseMessage,
      this.totalItems});

  List<AuditAssetData> data;
  int? responseCode;
  String responseStatus;
  dynamic totalItems;
  dynamic responseMessage;

  factory AuditAsset.fromJson(Map<String, dynamic> json) => AuditAsset(
        data: List<AuditAssetData>.from(
            json["Data"].map((x) => AuditAssetData.fromJson(x))),
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        totalItems: json["TotalItems"], //TotalItems
        responseMessage: json["ResponseMessage"],
      );
}

class AuditAssetData {
  AuditAssetData({
    this.auditDetailId,
    this.auditId,
    this.assetId,
    this.assetNumber,
    this.assetName,
    this.qrCode,
    this.epcCode,
    this.saveFlag,
    this.auditDStatus,
    this.auditDRemarks,
  });

  int? auditDetailId;
  int? auditId;
  int? assetId;
  String? assetNumber;
  String? assetName;
  String? qrCode;
  dynamic epcCode;
  bool? saveFlag;
  String? auditDStatus;
  String? auditDRemarks;

  factory AuditAssetData.fromJson(Map<String, dynamic> json) => AuditAssetData(
        auditDetailId: json["AuditDetailID"],
        auditId: json["AuditID"],
        assetId: json["AssetID"],
        assetNumber: json["AssetNumber"],
        assetName: json["AssetName"],
        qrCode: json["QRCode"],
        epcCode: json["EPCCode"],
        saveFlag: json["SaveFlag"],
        auditDStatus: json["AuditDStatus"],
        auditDRemarks: json["AuditDRemarks"],
      );
}
