// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_field

import 'package:ams/res/custom_colors.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  // Initial Selected Value
  String? dropdownvalue; //= 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
            child: DropdownButtonFormField(
              // Initial Value
              value: dropdownvalue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              hint: Text("Location"),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
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
            child: DropdownButtonFormField(
              // Initial Value
              value: dropdownvalue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              hint: Text("Sub-Location"),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
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
            child: DropdownButtonFormField(
              // Initial Value

              value: dropdownvalue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              hint: Text("User"),
              decoration: InputDecoration(enabledBorder: InputBorder.none),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            // width: size.width * 0.8,
            child: TextFormField(
              // maxLength: 4,
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.details,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
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
              textInputAction: TextInputAction.next,
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
