import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScannerNotifier extends ChangeNotifier {
  // Barcode? result;
  // QRViewController? controller;

  // @override
  // void addListener(VoidCallback listener) {
  //   // TODO: implement addListener
  //   super.addListener(listener);
  // }

  // void onQRViewCreated(QRViewController controller) {
  //   initController(controller);
  //   controller.scannedDataStream.listen(
  //     (scanData) {
  //       print('*' * 30);
  //       print(scanData.code);
  //       result = scanData;
  //     },
  //   );
  //   print('=========> end listen');
  //   notifyListeners();
  // }

  updateState() {
    notifyListeners();
  }

  // void initController(QRViewController controller) {
  //   this.controller = controller;
  //   notifyListeners();
  // }
}

final qrCodeScannerProvider = Provider.autoDispose<QrCodeScannerNotifier>((ref) {
  return QrCodeScannerNotifier();
});
