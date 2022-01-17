// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'dart:developer';

import 'package:ams/models/audit_asset_screen_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/audit/audit_scan_screen.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuditAssetScreen extends StatefulWidget {
  late int auditId;
  late String username, password;

  AuditAssetScreen(
      {Key? key,
      required this.auditId,
      required this.username,
      required this.password})
      : super(key: key);

  @override
  _AuditAssetScreenState createState() => _AuditAssetScreenState();
}

class _AuditAssetScreenState extends State<AuditAssetScreen> {
  bool isLoading = false;
  int totalItems = 0;
  late AsyncMemoizer<List<AuditAssetData>> _memoizer;

  @override
  void initState() {
    _memoizer = AsyncMemoizer<List<AuditAssetData>>();
    super.initState();
  }

  Future<List<AuditAssetData>> _fetchAudits(
      String username, String password, String auditId) async {
    return _memoizer.runOnce(() async {
      //await Future.delayed(const Duration(seconds: 1));

      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));
      var headers = {"Authorization": basicAuth};

      var queryParams = {"AuditID": auditId};

      final response = await http.get(
          Uri.parse(auditAssetList).replace(queryParameters: queryParams),
          headers: headers);

      print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
      print(response.body);
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var assets = AuditAsset.fromJson(json);

        if (assets.responseStatus == "Success") {
          print(
              "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
          print(assets.data[0].assetName);

          totalItems = assets.totalItems;
          return assets.data;
        } else {
          log('Failed to load Data from CDR API');
          List<AuditAssetData> emptyList = [];
          return emptyList;
        }
      }

      List<AuditAssetData> emptyList = [];
      return emptyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Audit ",
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
                  Text("Total: $totalItems"),
                  Text("Scanned: 1"),
                  Text("New: 0"),
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<List<AuditAssetData>>(
                future: _fetchAudits(widget.username, widget.password,
                    widget.auditId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data?.length != 0) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, top: 10, right: 15, left: 15),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Container(
                                  width: size.width * 0.9,
                                  child: Card(
                                    color:
                                        (snapshot.data![index].auditDStatus ==
                                                "COMPLETED")
                                            ? Colors.white
                                            : kPrimaryLightColor,
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
                                            Text(
                                                snapshot.data![index].assetName
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor,
                                                )),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                                snapshot.data![index].qrCode
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700],
                                                )),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            /*Text('Asset Information 2',
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
                                                )),*/
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.data?.length == 0) {
                    return Center(child: Text("No Data"));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
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
                return AuditScanScreen(
                  username: widget.username,
                  password: widget.password,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
