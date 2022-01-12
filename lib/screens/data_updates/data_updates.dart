// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable

import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/data_updates/physical_condition/physical_condition_screen.dart';
import 'package:flutter/material.dart';

class DataUpdatesScreen extends StatefulWidget {
  DataUpdatesScreen({Key? key}) : super(key: key);

  @override
  DataUpdatesScreenState createState() => DataUpdatesScreenState();
}

class DataUpdatesScreenState extends State<DataUpdatesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Updates",
        ),
        leading: BackButton(),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            /* onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuditScreen();
                  },
                ),
              );
            },*/
            child: Center(
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.85,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                  // color: kPrimaryLightColor,
                  child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Center(
                        child: const Text('Utilization Level Change',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                              color: kPrimaryColor,
                            )),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PhysicalConditionScreen();
                  },
                ),
              );
            },
            child: Center(
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.85,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                  // color: kPrimaryLightColor,
                  child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Center(
                        child: const Text('Physical Condition Change',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                              color: kPrimaryColor,
                            )),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          InkWell(
            /* onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuditScreen();
                  },
                ),
              );
            },*/
            child: Center(
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.85,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                  // color: kPrimaryLightColor,
                  child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Center(
                        child: const Text('Geo Updates',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                              color: kPrimaryColor,
                            )),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
