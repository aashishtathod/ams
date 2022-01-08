// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:developer';

import 'package:ams/res/custom_colors.dart';
import 'package:ams/screens/workflow/transfer/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TransferScanScreen extends StatefulWidget {
  TransferScanScreen({Key? key}) : super(key: key);

  @override
  _TransferScanScreenState createState() => _TransferScanScreenState();
}

class _TransferScanScreenState extends State<TransferScanScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scanVin = "";
  String? groupCode, dealerCode, dealerName, vin;
  bool isLoading = false,
      statusButtonVisible = false,
      submitButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          leading: const BackButton(),
          title: Text("Transfer"),
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
                  if (result != null)
                    Text(
                        'Vin: ${result!.code!.contains("#") ? result!.code!.substring(result!.code!.indexOf("#") + 1, result!.code!.indexOf("#") + 18) : result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
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
                          )),
                      Container(
                          margin: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 120, // <-- Your width
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: !submitButtonVisible
                                    ? Colors.grey
                                    : kPrimaryColor,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TransferScreen();
                                    },
                                  ),
                                );
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
          scanVin = (result!.code!.contains("#")
              ? result!.code!.substring(result!.code!.indexOf("#") + 1,
                  result!.code!.indexOf("#") + 18)
              : result!.code)!;
          if (scanVin == vin) {
            statusButtonVisible = true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Vin not matching with selected row!!!')),
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
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
