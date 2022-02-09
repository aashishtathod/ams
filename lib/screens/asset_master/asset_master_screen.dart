import 'dart:convert';
import 'dart:developer';

import 'package:ams/models/asst_master_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssetMasterScreen extends StatefulWidget {
  late String username, password;

  AssetMasterScreen({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _AssetMasterScreenState createState() => _AssetMasterScreenState();
}

class _AssetMasterScreenState extends State<AssetMasterScreen> {
  bool isLoading = false;
  int totalItems = 0;
  late AsyncMemoizer<List<AssetMasterData>> _memoizer;

  @override
  void initState() {
    _memoizer = AsyncMemoizer<List<AssetMasterData>>();
    super.initState();
  }

  var list;

  Future<List<AssetMasterData>> _fetchAssets(
      String username, String password) async {
    return _memoizer.runOnce(() async {
      //await Future.delayed(const Duration(seconds: 1));

      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));
      var headers = {"Authorization": basicAuth};

      final response = await http.get(Uri.parse(assetMaster), headers: headers);

      print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
      print(response.body);
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var assets = AssetMaster.fromJson(json);

        if (assets.responseStatus == "Success") {
          totalItems = assets.totalItems;

          setState(() {
            list = assets.data;
          });

          return assets.data;
        } else {
          log('Failed to load Data from aasetmasster API');
          List<AssetMasterData> emptyList = [];
          return emptyList;
        }
      }

      List<AssetMasterData> emptyList = [];
      return emptyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asset Master",
        ),
        leading: const BackButton(),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
              width: size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Total: $totalItems"),
                  //Text("Scanned: 1"),
                  // Text("New: 0"),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<List<AssetMasterData>>(
                future: _fetchAssets(widget.username, widget.password),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data?.length != 0 &&
                      list != null) {
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
                                            Text(
                                                snapshot.data![index].assetName
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor,
                                                )),
                                            /*  SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                                snapshot.data![index].assetId
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700],
                                                )),*/
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
      /*
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.qr_code_scanner_sharp,
          size: size.width * 0.07,
        ),
        onPressed: () {},
      ),*/
    );
  }
}
