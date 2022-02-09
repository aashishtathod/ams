import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ams/models/asset_details_model.dart';
import 'package:ams/models/users_model.dart';
import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RaiseTicketScreen extends StatefulWidget {
  late String username, password;
  late AssetData asset;

  RaiseTicketScreen(
      {Key? key,
      required this.username,
      required this.password,
      required this.asset})
      : super(key: key);

  @override
  _RaiseTicketScreenState createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? title, description;
  bool isloading = false;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  File? _selectedFile;

  UsersData? userValue;
  List<UsersData>? users;

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
        title: const Text("Raise Ticket"),
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
              child: TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none),
                  prefixIcon: Icon(
                    Icons.title,
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
                  hintText: "Title",
                ),
                controller: _titleController,
                onChanged: (value) {
                  _titleController.value = TextEditingValue(
                      text: value, //.toUpperCase(),
                      selection: _titleController.selection);
                },
                cursorColor: kPrimaryColor,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Title';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  title = val;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                maxLines: 3,
                minLines: 1,
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none),
                  prefixIcon: Icon(
                    Icons.details,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
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
                  hintText: "Description",
                ),
                controller: _descriptionController,
                onChanged: (value) {
                  _descriptionController.value = TextEditingValue(
                      text: value, //.toUpperCase(),
                      selection: _descriptionController.selection);
                },
                cursorColor: kPrimaryColor,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Description';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  description = val;
                },
              ),
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
              height: 30,
            ),
            InkWell(
              onTap: () async {
                try {
                  _imageFile =
                      await _picker.getImage(source: ImageSource.camera);

                  if (_imageFile != null) {
                    setState(() {
                      _selectedFile = File(_imageFile!.path);
                    });
                  }
                } catch (e) {}
              },
              child: Container(
                height: 80,
                width: 80,
                child: (_selectedFile == null)
                    ? const Icon(
                        Icons.camera_alt,
                        color: kPrimaryColor,
                        size: 40,
                      )
                    : Image(
                        image: FileImage(_selectedFile!),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  raiseTicket();
                }
              },
              child: Text("       Raise Ticket       "),
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

  raiseTicket() async {
    String username = widget.username; //widget.username;
    String password = widget.password;
    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Wait !!")));

      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var request = http.MultipartRequest("POST", Uri.parse(ticketRequest));

      request.headers.addAll({"Authorization": basicAuth});

      if (_imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "ImagePath", _selectedFile!.path));
      }

      request.fields["AssetID"] = widget.asset.assetId.toString();
      request.fields["AssignID"] = userValue!.userId.toString();
      request.fields["Title"] = _titleController.text.toString();
      request.fields["Description"] = _descriptionController.text.toString();
      request.fields["Status"] = "Open";

      var response = await request.send();

      log(response.toString());
      print(response);

      if (response.statusCode == 200) {
        showAlertDialog(context, "Success", "Ticket Raised Successfully");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(" 1 Something went wrong, please try again !")));
      }
    } catch (e) {
      log(e.toString());
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(" 2 Something went wrong, please try again !")));
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
