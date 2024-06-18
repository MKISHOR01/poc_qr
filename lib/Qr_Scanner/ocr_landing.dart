import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:poc_qr/Qr_Scanner/qr_result.dart';
import 'package:poc_qr/dialogs/Image_Picker_dialog.dart';
import 'package:poc_qr/utils/app_theme.dart';
import 'package:poc_qr/utils/image_picker_util.dart';

class OCRLandingPage extends StatefulWidget {
  const OCRLandingPage({super.key});

  @override
  State<OCRLandingPage> createState() => _OCRLandingPageState();
}

class _OCRLandingPageState extends State<OCRLandingPage> {
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScannCompleted = false;
  String qrResult = '';
  MobileScannerController mobileScannerController = MobileScannerController();

  void closeScreen() {
    isScannCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white.withOpacity(0.0),
        appBar: AppBar(
          backgroundColor: AppTheme.white.withOpacity(0.0),
          title: const Text(
            'QR Code Scanner',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: InkWell(
              onTap: () async {
                final selection =
                    await showImagePickerDialog(context, closeClick: () {});
                await handleMediaSelection(selection);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppTheme.nearlyDarkBlue,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Upload / Capture file",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),
        ));
  }

  Future handleMediaSelection(
    selection,
  ) async {
    if (selection == null) return null;

    final file = selection == MediaSelection.gallery
        ? await ImagePickerUtil.pickImageFromGallery()
        : await ImagePickerUtil.pickImageFromCamera();

    if (file != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return QRResult(
          image: file.path,
          type: "image",
          closeScanner: () {
            closeScreen();
          },
        );
      }));
    }

    return null;
  }
}
