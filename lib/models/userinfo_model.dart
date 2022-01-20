// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

class UserInfo {
  UserInfo({
    required this.responseCode,
    required this.responseStatus,
    required this.responseMessage,
    required this.totalItems,
    this.data,
  });

  int responseCode;
  String responseStatus;
  String responseMessage;
  int totalItems;
  List<UserInfoData>? data;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        totalItems: json["TotalItems"],
        data: List<UserInfoData>.from(
            json["Data"].map((x) => UserInfoData.fromJson(x))),
      );
}

class UserInfoData {
  UserInfoData({
    required this.userId,
    required this.userName,
    this.userCode,
    this.address,
  });

  int userId;
  String userName;
  String? userCode;
  String? address;

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        userId: json["UserID"],
        userName: json["UserName"],
        userCode: json["UserCode"],
        address: json["Address"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "UserName": userName,
        "UserCode": userCode,
        "Address": address,
      };
}
