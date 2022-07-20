import 'package:application_template/mixin/toast.dart';
import 'package:application_template/screen/qr_code_scanner/qr_code_scanner_screen.dart';
import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../notifier/authentication/local_auth_notifier.dart';
import '../qr_code_scanner/mobile_scanner_screen.dart';
import 'face_detector_view.dart';

class MainPage extends HookConsumerWidget with Toast {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _localAuth = ref.watch(LocalAuthProvider);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Unlock local Auth Verification',
              onPressed: () async {
                showLoading();
                var isVerified = await _localAuth.localAuth();
                hideLoading();

                if (isVerified) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(),
                      body: Center(child: Text('Success ')),
                    );
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(),
                      body: Center(child: Text('Falied ')),
                    );
                  }));
                }
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Google ML kit face detection',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FaceDetectorView()));
              },
            ),
            // SizedBox(height: 20),
            // CustomButton(
            //   title: 'Scan QR Code \nPlugin: qr_code_scanner',
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => QRViewExample()));
            //   },
            // ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Scan QR Code \nPlugin: mobile_scanner',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScannerScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
