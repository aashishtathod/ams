// To parse this JSON data, do
//
//     final subLocation = subLocationFromJson(jsonString);

import 'dart:convert';

SubLocation subLocationFromJson(String str) =>
    SubLocation.fromJson(json.decode(str));

class SubLocation {
  SubLocation({
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
  List<SublocationData> data;

  factory SubLocation.fromJson(Map<String, dynamic> json) => SubLocation(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        totalItems: json["TotalItems"],
        data: List<SublocationData>.from(
            json["Data"].map((x) => SublocationData.fromJson(x))),
      );
}

class SublocationData {
  SublocationData({
    required this.locationId,
    required this.locationCode,
    required this.locationName,
    required this.subLocationId,
    required this.subLocationCode,
    required this.subLocationName,
  });

  int locationId;
  String locationCode;
  String locationName;
  int subLocationId;
  String subLocationCode;
  String subLocationName;

  factory SublocationData.fromJson(Map<String, dynamic> json) =>
      SublocationData(
        locationId: json["LocationID"],
        locationCode: json["LocationCode"],
        locationName: json["LocationName"],
        subLocationId: json["SubLocationID"],
        subLocationCode: json["SubLocationCode"],
        subLocationName: json["SubLocationName"],
      );
}
