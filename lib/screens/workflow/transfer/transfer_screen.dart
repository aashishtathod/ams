// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_field

import 'package:ams/res/custom_colors.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  bool isLoading = false;
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
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _userController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      hintText: "User",
                      prefixIcon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    _userController.value = TextEditingValue(
                        text: value, //.toUpperCase(),
                        selection: _userController.selection);
                  },
                  onSaved: (val) {
                    user = val;
                  },
                  validator: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _addressController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      hintText: "Location",
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    _addressController.value = TextEditingValue(
                        text: value, //.toUpperCase(),
                        selection: _addressController.selection);
                  },
                  onSaved: (val) {
                    address = val;
                  },
                  validator: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _subAddressController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      hintText: "Sub-Location",
                      prefixIcon: Icon(
                        Icons.villa,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    _subAddressController.value = TextEditingValue(
                        text: value, //.toUpperCase(),
                        selection: _subAddressController.selection);
                  },
                  onSaved: (val) {
                    subAddress = val;
                  },
                  validator: (value) {},
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _remarksControler,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      hintText: "Remarks",
                      prefixIcon: Icon(
                        Icons.note_alt_outlined,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    _remarksControler.value = TextEditingValue(
                        text: value, //.toUpperCase(),
                        selection: _remarksControler.selection);
                  },
                  onSaved: (val) {
                    remarks = val;
                  },
                  validator: (value) {},
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Transfer",
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
