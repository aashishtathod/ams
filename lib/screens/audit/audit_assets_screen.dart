// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/audit/audit_scan_screen.dart';
import 'package:flutter/material.dart';

class AuditAssetScreen extends StatefulWidget {
  late int auditId;
  AuditAssetScreen({Key? key, required this.auditId}) : super(key: key);

  @override
  _AuditAssetScreenState createState() => _AuditAssetScreenState();
}

class _AuditAssetScreenState extends State<AuditAssetScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Audit 1",
        ),
        leading: BackButton(),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
              width: size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Total: 2"),
                  Text("Scanned: 1"),
                  Text("New: 0"),
                ],
              )),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {},
            child: Center(
              child: Container(
                width: size.width * 0.9,
                child: Card(
                  color: kPrimaryLightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                  // color: kPrimaryLightColor,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          Text('Asset 1',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Text('Asset Information 1',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Asset Information 2',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Asset Information 3',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              )),
                        ],
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          InkWell(
            onTap: () {},
            child: Center(
              child: Container(
                width: size.width * 0.9,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                  // color: kPrimaryLightColor,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          Text('Asset 1',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Text('Asset Information 1',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Asset Information 2',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('Asset Information 3',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              )),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.qr_code_scanner_sharp,
          size: size.width * 0.07,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AuditScanScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
