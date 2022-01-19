// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_field

import 'dart:convert';
import 'dart:developer';

import 'package:ams/models/locations_model.dart';
import 'package:ams/models/sublocation_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransferScreen extends StatefulWidget {
  late String username, password;

  TransferScreen({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  LocationData? locationValue;
  SublocationData? subLocationValue;

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

  List<LocationData>? locations = [];
  List<SublocationData>? subLocations = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? user, address, subAddress, remarks;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _subAddressController = TextEditingController();
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
              keyboardType: TextInputType.emailAddress,
              onSaved: (val) {
                remarks = val;
              },
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
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
}
