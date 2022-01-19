// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_field

import 'package:ams/models/asset_details_model.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/workflow/transfer/transfer_screen.dart';
import 'package:flutter/material.dart';

class TransferAssetDetailsScreen extends StatefulWidget {
  late Data asset;
  String? username, password;

  TransferAssetDetailsScreen(
      {Key? key, required this.asset, this.username, this.password})
      : super(key: key);

  @override
  _TransferAssetDetailsScreenState createState() =>
      _TransferAssetDetailsScreenState();
}

class _TransferAssetDetailsScreenState
    extends State<TransferAssetDetailsScreen> {
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
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TransferScreen(
                          username: widget.username!,
                          password: widget.password!,
                        );
                      },
                    ),
                  );
                },
                child: Text(" Proceed  to  Transfer "),
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ));
  }
}
