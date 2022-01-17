// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:ams/res/constants.dart';
import 'package:ams/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AuditScanScreen extends StatefulWidget {
  late String username, password;

  AuditScanScreen({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _AuditScanScreenState createState() => _AuditScanScreenState();
}

class _AuditScanScreenState extends State<AuditScanScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scannedCode = "";
  String? groupCode, dealerCode, dealerName, vin;
  bool isLoading = false,
      statusButtonVisible = false,
      submitButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          leading: const BackButton(),
          title: Text("Audit 1"),
        ),
        body: Column(children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  if (result != null)
                    Text(
                        '${result!.code!.contains("#") ? result!.code!.substring(result!.code!.indexOf("#") + 1, result!.code!.indexOf("#") + 18) : result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      /* Container(
                          margin: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 120, // <-- Your width
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: !statusButtonVisible
                                    ? Colors.grey
                                    : kPrimaryColor,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                              ),
                              onPressed: () {},
                              /* onPressed: !statusButtonVisible
                                ? null
                                : () async {
                                    checkStatus(scanVin, dealerCode);
                                  },*/
                              child: const Text('Check Status',
                                  style: TextStyle(fontSize: 12)),
                            ),
                          )),*/
                      Container(
                          margin: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 120, // <-- Your width
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: !submitButtonVisible
                                    ? Colors.grey
                                    : kPrimaryColor,
                                //onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                              ),
                              onPressed: () {
                                !submitButtonVisible
                                    ? null
                                    : updateStatus(widget.username,
                                        widget.password, scannedCode);
                              },
                              /* onPressed: !submitButtonVisible
                                ? null
                                : () async {
                                    updateStatus(scanVin, groupCode, dealerCode,
                                        dealerName);
                                  },*/
                              child: const Text('Submit',
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ]));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          scannedCode = (result!.code!.contains("#")
              ? result!.code!.substring(result!.code!.indexOf("#") + 1,
                  result!.code!.indexOf("#") + 18)
              : result!.code)!;
          if (scannedCode != null) {
            setState(() {
              submitButtonVisible = true;
            });
          } else {
            //statusButtonVisible = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Code not valid!!!')),
            );
          }
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera Permission Denied')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void updateStatus(String username, String password, String qrcode) async {
    try {
      String basicAuth =
          "Basic " + base64Encode(utf8.encode("$username:$password"));

      var headers = {"Authorization": basicAuth};
      var body = {"QRCode": qrcode};

      var response = await http.post(Uri.parse(updateScannedAuditAsset),
          body: body, headers: headers);

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(response.body);

        if (json["ResponseStatus"] == "SUCCESS") {
          print(response.body);
          showAlertDialog(context, "Success");

          setState(() {
            result = null;
            scannedCode = "";
            submitButtonVisible = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to update, please try again !")));
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to update, please try again !")));
    }
  }

  showAlertDialog(BuildContext context, String title) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Icon(
        Icons.done_all,
        color: Colors.green,
        size: 60,
      ),
      /*actions: [
        okButton,
      ],*/
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
