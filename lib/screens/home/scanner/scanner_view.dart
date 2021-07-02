import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/scanner/scanner_product.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerView extends StatefulWidget {
  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  double value = 200;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return result != null
        ? ScannerProduct(result)
        : Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(flex: 4, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 440,
                              child: Row(
                                children: [
                                  Text('Taille du scanner',
                                      style: TextStyle(
                                        fontSize: 22,
                                      )),
                                  Expanded(
                                    child: Slider(
                                      value: value,
                                      divisions: MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              MediaQuery.of(context).size.height
                                          ? MediaQuery.of(context)
                                              .size
                                              .width
                                              .round()
                                          : MediaQuery.of(context)
                                              .size
                                              .height
                                              .round(),
                                      min: 20,
                                      max: MediaQuery.of(context).size.width <
                                              MediaQuery.of(context).size.height
                                          ? MediaQuery.of(context).size.width
                                          : MediaQuery.of(context).size.height,
                                      label:
                                          '${value.round()} x ${value.round()}',
                                      activeColor: opi_cf_color_secondary,
                                      inactiveColor: Colors.red.shade100,
                                      onChanged: (value) =>
                                          setState(() => this.value = value),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getFlashStatus(),
                                    builder: (context, snapshot) {
                                      return Text('Flash');
                                    },
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.pauseCamera();
                                },
                                child: Text('pause',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.resumeCamera();
                                },
                                child: Text('resume',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = value;
    /* (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0; */
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
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
