// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

class Users {
  Users({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.totalItems,
    this.data,
  });

  int? responseCode;
  String? responseStatus;
  String? responseMessage;
  int? totalItems;
  List<UsersData>? data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        totalItems: json["TotalItems"],
        data: List<UsersData>.from(
            json["Data"].map((x) => UsersData.fromJson(x))),
      );
}

class UsersData {
  UsersData({
    required this.userId,
    required this.userName,
  });

  int userId;
  String userName;

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
        userId: json["UserID"],
        userName: json["UserName"],
      );
}
