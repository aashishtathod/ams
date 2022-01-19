// To parse this JSON data, do
//
//     final assetDetails = assetDetailsFromJson(jsonString);

import 'dart:convert';

Location assetDetailsFromJson(String str) =>
    Location.fromJson(json.decode(str));

class Location {
  Location({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.totalItems,
    required this.data,
  });

  int? responseCode;
  String? responseStatus;
  String? responseMessage;
  int? totalItems;
  List<LocationData> data;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        totalItems: json["TotalItems"],
        data: List<LocationData>.from(
            json["Data"].map((x) => LocationData.fromJson(x))),
      );
}

class LocationData {
  LocationData({
    required this.locationId,
    required this.locationCode,
    required this.locationName,
  });

  int locationId;
  String locationCode;
  String locationName;

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        locationId: json["LocationID"],
        locationCode: json["LocationCode"],
        locationName: json["LocationName"],
      );
}
