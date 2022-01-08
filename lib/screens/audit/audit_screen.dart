// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/audit/audit_assets_screen.dart';
import 'package:ams/screens/audit/audit_scan_screen.dart';
import 'package:flutter/material.dart';

class AuditScreen extends StatelessWidget {
  const AuditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Audit",
          ),
          leading: BackButton(),
          backgroundColor: kPrimaryColor,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              InkWell(
                onTap: () {},
                child: Center(
                  child: Container(
                    //height: size.height * 0.1,
                    width: size.width * 0.85,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      shadowColor: Colors.blueAccent,
                      elevation: 10,
                      // color: kPrimaryLightColor,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('Audit 1',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text('Audit Information 1',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('Audit Information 2',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('Audit Information 3',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return AuditAssetScreen();
                                              },
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.0),
                                          ),
                                        ),
                                        child: Text(" Start "),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.0),
                                          ),
                                        ),
                                        child: Text("Report"),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InkWell(
                onTap: () {},
                child: Center(
                  child: Container(
                    //height: size.height * 0.1,
                    width: size.width * 0.85,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      shadowColor: Colors.blueAccent,
                      elevation: 10,
                      // color: kPrimaryLightColor,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('Audit 2',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text('Audit Information 1',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('Audit Information 2',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      )),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('Audit Information 3',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.0),
                                          ),
                                        ),
                                        child: Text(" Start "),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.0),
                                          ),
                                        ),
                                        child: Text("Report"),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
/*
Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Audit',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Roboto',
                                  color: kPrimaryColor,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                  ),
                                  child: Text("Start"),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                  ),
                                  child: Text("Report"),
                                ),
                              ],
                            )
                          ],
                        ),
*/
