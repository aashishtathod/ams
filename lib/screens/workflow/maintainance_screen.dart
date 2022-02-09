import 'dart:convert';

import 'package:ams/models/asset_details_model.dart';
import 'package:ams/models/users_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MaintainanceScreen extends StatefulWidget {
  late String username, password;
  late AssetData asset;

  MaintainanceScreen(
      {Key? key,
      required this.username,
      required this.password,
      required this.asset})
      : super(key: key);

  @override
  _MaintainanceScreenState createState() => _MaintainanceScreenState();
}

class _MaintainanceScreenState extends State<MaintainanceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title, description;
  bool isloading = false;

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _EndDateController = TextEditingController();

  UsersData? userValue;
  List<UsersData>? users;

  String? startDate;
  String? endDate;

  String? periodValue;
  List<String> periodList = [
    "Daily",
    "Weekly",
    "Monthly",
    "Half Yearly",
    "Yearly"
  ];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: const BackButton(),
        title: const Text("Asset Maintenance"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(90)),
              child: DropdownButtonFormField<UsersData>(
                onTap: () {
                  if (users == []) {
                    fetchUsers();
                  }
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none, labelText: "To User"),
                isExpanded: true,
                hint: Text(" To User"),
                value: userValue,
                items: users?.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.userName.toString()),
                      );
                    })?.toList() ??
                    [],
                onChanged: (newValue) {
                  setState(() {
                    userValue = newValue;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0, left: 10),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(
                    Icons.event,
                    color: kPrimaryColor,
                  ),
                  dateLabelText: 'Start Date',
                  onChanged: (val) => setState(() {
                    startDate = val.toString();
                  }),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => setState(() {
                    startDate = val.toString();
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0, left: 10),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(
                    Icons.event,
                    color: kPrimaryColor,
                  ),
                  dateLabelText: 'End Date',
                  onChanged: (val) => (setState(() {
                    endDate = val.toString();
                  })),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => setState(() {
                    endDate = val.toString();
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30)),
              child: DropdownButtonFormField<String>(
                onTap: () {},
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  labelText: "Period",
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none),
                ),
                isExpanded: true,
                hint: Text("Period"),
                value: periodValue,
                items: periodList.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    periodValue = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (userValue != null &&
                    startDate != null &&
                    endDate != null &&
                    periodValue != null) {
                  raiseMaintenance();
                }
              },
              child: const Text("       Raise Maintenance       "),
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ],
        ),
      ),
    );
  }

  Future fetchUsers() async {
    String username = widget.username; //widget.username;
    String password = widget.password; // widget.password;
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var headers = {"Authorization": basicAuth};
      var response = await http.get(Uri.parse(userList), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = Users.fromJson(json);

        if (data.responseStatus == "Success") {
          setState(() {
            if (data.data != null) {
              users = data.data;
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

  raiseMaintenance() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Please Wait !!")));

    String username = widget.username; //widget.username;
    String password = widget.password; // widget.password;
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var header = {"Authorization": basicAuth};
      var body = {
        "AssetID": widget.asset.assetId.toString(),
        "AssignID": userValue!.userId.toString(),
        "StartDate": startDate.toString(),
        "EndDate": endDate.toString(),
        "Type": periodValue.toString()
      };
      var response = await http.post(Uri.parse(maintenanceRequest),
          headers: header, body: body);

      setState(() {
        isloading = !isloading;
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json["Response"] == "Success") {
          showAlertDialog(
              context, "Success", "Maintenance Request Successfully raised.");
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
