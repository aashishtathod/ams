// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/audit/audit_screen.dart';
import 'package:ams/screens/data_updates/data_updates.dart';
import 'package:ams/screens/workflow/workflow_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AMS",
        ),
        leading: BackButton(),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuditScreen();
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
                        child: const Text('Audit',
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
                    return WorkflowScreen();
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
                        child: const Text('Workflow',
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
                    return DataUpdatesScreen();
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
                        child: const Text('Data Updates',
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
                        child: const Text('Data Retrieval',
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
          /*InkWell(
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
                        child: const Text('Dashboard',
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
          ),*/
        ],
      ),
    );
  }
}
