// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:ams/res/custom_colors.dart';
import 'package:ams/res/tags.dart';
import 'package:ams/screens/workflow/scan_screen.dart';
import 'package:flutter/material.dart';

class WorkflowScreen extends StatefulWidget {
  late String username, password;

  WorkflowScreen({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _WorkflowScreenState createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Workflow",
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
                        return ScanScreen(
                          username: widget.username,
                          password: widget.password,
                          screen: TRANSFER_TAG,
                        );
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
                            child: const Text('Transfer',
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
                        return ScanScreen(
                          username: widget.username,
                          password: widget.password,
                          screen: SALE_TAG,
                        );
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
                            child: const Text('Sale',
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
                        return ScanScreen(
                          username: widget.username,
                          password: widget.password,
                          screen: DISCARD_TAG,
                        );
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
                            child: const Text('Discard',
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
                        return ScanScreen(
                          username: widget.username,
                          password: widget.password,
                          screen: TICKET_TAG,
                        );
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
                            child: const Text('Raise Ticket',
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
                        return ScanScreen(
                          username: widget.username,
                          password: widget.password,
                          screen: MAINTAINANCE_TAG,
                        );
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
                            child: const Text('Asset Maintainance',
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
            ]));
  }
}
