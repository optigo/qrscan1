// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


void main() => runApp(QRCodeScannerApp());

class QRCodeScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      home: QRCodeScannerScreen(),
    );
  }
}

class QRCodeScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QRCodeScannerScreenState();
}

class QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  bool scanning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("QR Code Scanner"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(scanning ? 'Scanning...' : 'Scan a QR Code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scanning = true;
      });
      // Handle the scanned QR code data here
      print('Scanned data: ${scanData.code}');
      
      // You can perform any action you want with the scanned data.
      // For example, navigate to a new screen or display it in a dialog.
      
      // After processing the data, stop scanning for a moment to avoid multiple scans
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            scanning = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

