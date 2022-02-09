// To parse this JSON data, do
//
//     final assetMaster = assetMasterFromJson(jsonString);

import 'dart:convert';

AssetMaster assetMasterFromJson(String str) =>
    AssetMaster.fromJson(json.decode(str));

class AssetMaster {
  AssetMaster({
    required this.responseCode,
    required this.responseStatus,
    required this.responseMessage,
    required this.totalItems,
    required this.data,
  });

  int responseCode;
  String responseStatus;
  String responseMessage;
  int totalItems;
  List<AssetMasterData> data;

  factory AssetMaster.fromJson(Map<String, dynamic> json) => AssetMaster(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        totalItems: json["TotalItems"],
        data: List<AssetMasterData>.from(
            json["Data"].map((x) => AssetMasterData.fromJson(x))),
      );
}

class AssetMasterData {
  AssetMasterData({
    required this.assetId,
    required this.assetName,
  });

  int assetId;
  String assetName;

  factory AssetMasterData.fromJson(Map<String, dynamic> json) =>
      AssetMasterData(
        assetId: json["AssetID"],
        assetName: json["AssetName"],
      );
}
