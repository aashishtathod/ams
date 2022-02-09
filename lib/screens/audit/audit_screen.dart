// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'dart:developer';

import 'package:ams/models/audit_screen_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/audit/audit_assets_screen.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuditScreen extends StatefulWidget {
  late String username, password;

  AuditScreen({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _AuditScreenState createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  bool isLoading = false;
  late AsyncMemoizer<List<AuditData>> _memoizer;

  @override
  void initState() {
    _memoizer = AsyncMemoizer<List<AuditData>>();
    super.initState();
  }

  var list;

  Future<List<AuditData>> _fetchAudits(String username, String password) async {
    return _memoizer.runOnce(() async {
      //await Future.delayed(const Duration(seconds: 1));

      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));
      var headers = {"Authorization": basicAuth};

      final response = await http.get(Uri.parse(auditList), headers: headers);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        /*  var audits;
        for (var value in json) {
          audits = Audit.fromJson(value);
          print(value);
        }
*/
        var audits = Audit.fromJson(json);

        if (audits.responseStatus == "Success") {
          setState(() {
            list = audits.data;
          });
          return audits.data;
        } else {
          log('Failed to load Data from CDR API');
          List<AuditData> emptyList = [];
          return emptyList;
        }
      }

      // log('Failed to load Data from CDR API');
      List<AuditData> emptyList = [];
      return emptyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Audit"),
          leading: BackButton(),
          backgroundColor: kPrimaryColor,
        ),
        body: FutureBuilder<List<AuditData>>(
            future: _fetchAudits(widget.username, widget.password),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data?.length != 0 &&
                  list != null) {
                return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 10, right: 15, left: 15),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
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
                                        width: size.width * 0.9,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          shadowColor: Colors.blueAccent,
                                          elevation: 10,
                                          // color: kPrimaryLightColor,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              child: Column(
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text(
                                                        snapshot.data![index]
                                                            .auditCode
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColor,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .auditStatus
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .grey[700],
                                                              )),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .auditStartDate
                                                                  .toString()
                                                                  .trim()
                                                                  .substring(
                                                                      0, 11),
                                                              style: TextStyle(
                                                                fontSize: 17.0,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black87,
                                                              )),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .auditEndDate
                                                                  .toString()
                                                                  .trim()
                                                                  .substring(
                                                                      0, 11),
                                                              style: TextStyle(
                                                                fontSize: 17.0,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black87,
                                                              )),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return AuditAssetScreen(
                                                                          auditId: snapshot
                                                                              .data![index]
                                                                              .auditId,
                                                                          username:
                                                                              widget.username,
                                                                          password:
                                                                              widget.password,
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      kPrimaryColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            29.0),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                    " Start "),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      kPrimaryColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            29.0),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                    "Report"),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ]),
                          ));
                    });
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.data?.length == 0) {
                return Center(child: Text("No Data"));
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
/*






        /*Column(
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
            ])*/
        );
  }
}



 */
}
