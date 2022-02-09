// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_field

import 'dart:convert';
import 'dart:developer';

import 'package:ams/models/asset_details_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:ams/res/tags.dart';
import 'package:ams/screens/workflow/maintainance_screen.dart';
import 'package:ams/screens/workflow/raise_ticket_screen.dart';
import 'package:ams/screens/workflow/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssetDetailsScreen extends StatefulWidget {
  late AssetData asset;
  String? username, password, screen;

  AssetDetailsScreen(
      {Key? key,
      required this.asset,
      this.username,
      this.password,
      this.screen})
      : super(key: key);

  @override
  _AssetDetailsScreenState createState() => _AssetDetailsScreenState();
}

class _AssetDetailsScreenState extends State<AssetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          leading: const BackButton(),
          title: Text("Current Asset Details"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      "Asset Name :",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade700),
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      widget.asset.assetName.toString(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      "Current User :",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade700),
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      widget.asset.assignedName.toString(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      "Current Location :",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade700),
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      widget.asset.subLocationName.toString(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      "Current Sub-Location :",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade700),
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: Text(
                      widget.asset.subLocationName.toString(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (widget.screen == TRANSFER_TAG) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TransferScreen(
                            qrcode: widget.asset.assetCode!,
                            username: widget.username!,
                            password: widget.password!,
                            fromLocationId: widget.asset.locationId.toString(),
                            fromSubLocationId:
                                widget.asset.subLocationId.toString(),
                          );
                        },
                      ),
                    );
                  } else if (widget.screen == SALE_TAG) {
                    saleAndDiscard(widget.screen);
                  } else if (widget.screen == DISCARD_TAG) {
                    saleAndDiscard(widget.screen);
                  } else if (widget.screen == TICKET_TAG) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RaiseTicketScreen(
                            username: widget.username!,
                            password: widget.password!,
                            asset: widget.asset,
                          );
                        },
                      ),
                    );
                  } else if (widget.screen == MAINTAINANCE_TAG) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MaintainanceScreen(
                            username: widget.username!,
                            password: widget.password!,
                            asset: widget.asset,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Text("   Proceed   "),
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ));
  }

  saleAndDiscard(String? screen) async {
    var date = DateUtils.dateOnly(DateTime.now().toLocal())
        .toString()
        .substring(0, 11);

    log(date.toString());

    String? username = widget.username; //widget.username;
    String? password = widget.password; // widget.password;
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var header = {"Authorization": basicAuth};
      var body = {
        "FromLocationID": widget.asset.locationId.toString(),
        "AssetCode": widget.asset.assetCode.toString(),
        "RequestDate": date,
        "DRStatus": "PENDING"
      };
      var response;

      if (screen == SALE_TAG) {
        response =
            await http.post(Uri.parse(saleApi), headers: header, body: body);
      } else {
        response =
            await http.post(Uri.parse(discardApi), headers: header, body: body);
      }

      log(response.body);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json["ResponseCode"] == 200) {
          if (screen == SALE_TAG) {
            showAlertDialog(
                context, "Success", "Asset details updated to \"Sold Off\"");
          } else {
            showAlertDialog(
                context, "Success", "Asset details updated to \"Scraped Off\"");
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(json["ResponseMessage"].toString())));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong, please try again !")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(" Something went wrong, please try again !")));
    }
  }

  showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
