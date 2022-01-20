// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_field

import 'dart:convert';
import 'dart:developer';

import 'package:ams/models/locations_model.dart';
import 'package:ams/models/sublocation_model.dart';
import 'package:ams/models/userinfo_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransferScreen extends StatefulWidget {
  late String username, password, fromLocationId, fromSubLocationId;

  TransferScreen(
      {Key? key,
      required this.username,
      required this.password,
      required this.fromLocationId,
      required this.fromSubLocationId})
      : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  LocationData? locationValue;
  SublocationData? subLocationValue;
  UserInfoData? userInfoValue;

  List<LocationData>? locations = [];
  List<SublocationData>? subLocations = [];
  List<UserInfoData>? userInfos = [];

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future fetchLocations() async {
    String username = widget.username; //widget.username;
    String password = widget.password; // widget.password;
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var headers = {"Authorization": basicAuth};
      var response = await http.get(Uri.parse(location), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = Location.fromJson(json);

        if (data.responseStatus == "Success") {
          setState(() {
            if (data.data != null) {
              locations = data.data;
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Something went wrong, please try again !")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong, please try again !")));
      }
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(" Something went wrong, please try again !")));
    }
  }

  Future fetchSubLocations(int locationId) async {
    String username = widget.username; //widget.username;
    String password = widget.password; // widget.password;
    try {
      log(locationId.toString());

      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var header = {"Authorization": basicAuth};
      var params = {"LocationID": locationId.toString()};
      var response = await http.get(
          Uri.parse(subLocation).replace(queryParameters: params),
          headers: header);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = SubLocation.fromJson(json);

        if (data.responseStatus == "Success") {
          setState(() {
            if (data.data != null) {
              subLocations = data.data;
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(" Something went wrong, please try again !")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(" Something went wrong, please try again !")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, please try again !")));
    }
  }

  Future fetchUserInfo(int locationId, int subLocationId) async {
    String username = widget.username; //widget.username;
    String password = widget.password; // widget.password;
    try {
      log(locationId.toString());

      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var header = {"Authorization": basicAuth};
      var params = {
        "LocationID": locationId.toString(),
        "SubLocationID": subLocationId.toString()
      };
      var response = await http.get(
          Uri.parse(userInfo).replace(queryParameters: params),
          headers: header);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = UserInfo.fromJson(json);

        if (data.responseStatus == "Success") {
          setState(() {
            if (data.data != null) {
              userInfos = data.data;
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(" Something went wrong, please try again !")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(" Something went wrong, please try again !")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, please try again !")));
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? remarks;
  bool isloading = false;
  final TextEditingController _remarksControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: const BackButton(),
        title: Text("Transfer To"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButtonFormField<LocationData>(
              onTap: () {
                if (locations == []) {
                  setState(() {
                    subLocations = [];
                    subLocationValue = null;
                    fetchLocations();
                  });
                }
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              isExpanded: true,
              hint: Text("Location"),
              value: locationValue,
              items: locations?.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.locationName.toString()),
                    );
                  })?.toList() ??
                  [],
              onChanged: (newValue) {
                setState(() {
                  locationValue = newValue;

                  if (locationValue != null) {
                    setState(() {
                      subLocations = [];
                      subLocationValue = null;
                      userInfoValue = null;
                      userInfos = [];
                      fetchSubLocations(locationValue!.locationId);
                    });
                  }
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButtonFormField<SublocationData>(
              onTap: () {
                if (subLocations == [] && locationValue!.locationId != null) {
                  fetchSubLocations(locationValue!.locationId);
                }
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              isExpanded: true,
              hint: Text("Sub-Location"),
              value: subLocationValue,
              items: subLocations?.map((SublocationData item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.subLocationName.toString()),
                    );
                  })?.toList() ??
                  [],
              onChanged: (newValue) {
                setState(() {
                  subLocationValue = newValue;
                  userInfoValue = null;
                  userInfos = [];
                  fetchUserInfo(locationValue!.locationId,
                      subLocationValue!.subLocationId);
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButtonFormField<UserInfoData>(
              onTap: () {
                if (subLocations == [] && locationValue!.locationId != null) {
                  fetchSubLocations(locationValue!.locationId);
                }
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              isExpanded: true,
              hint: Text("User"),
              value: userInfoValue,
              items: userInfos?.map((UserInfoData item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.userName.toString()),
                    );
                  })?.toList() ??
                  [],
              onChanged: (newValue) {
                setState(() {
                  userInfoValue = newValue;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              autofocus: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.details,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                counterText: "",
                errorStyle: TextStyle(color: Colors.red),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                filled: true,
                fillColor: kPrimaryLightColor,
                hintText: "Remarks",
              ),
              controller: _remarksControler,
              onChanged: (value) {
                _remarksControler.value = TextEditingValue(
                    text: value, //.toUpperCase(),
                    selection: _remarksControler.selection);
              },
              cursorColor: kPrimaryColor,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              onSaved: (val) {
                remarks = val;
              },
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              /* if (locationValue != null &&
                      subLocationValue != null &&
                      userInfoValue != null &&
                  !isloading
                  ) {*/
              isloading = !isloading;

              transfer();
              //   }
            },
            child: Text("          Transfer          "),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
        ],
      ),
    );
  }

  transfer() async {
    var date = DateUtils.dateOnly(DateTime.now().toLocal())
        .toString()
        .substring(0, 11);

    log(date.toString());

    String username = widget.username; //widget.username;
    String password = widget.password; // widget.password;
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var header = {"Authorization": basicAuth};
      var body = {
        "FromLocationID": widget.fromLocationId,
        "FromSubLocationID": widget.fromSubLocationId,
        "TransferDate": date,
        "TRUserID": userInfoValue!.userId.toString(),
        "TRRemarks": _remarksControler.text,
        "ToLocationID": locationValue!.locationId.toString(),
        "ToSubLocationID": subLocationValue!.subLocationId.toString()
      };
      var response =
          await http.post(Uri.parse(transferApi), headers: header, body: body);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json["Response"] == "Success") {
          showAlertDialog(
              context, "Success", "Transfer Request Successfully raised.");
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
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
