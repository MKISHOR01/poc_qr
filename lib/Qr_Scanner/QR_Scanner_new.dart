import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:poc_qr/Qr_Scanner/qr_result.dart';
import 'package:poc_qr/dialogs/Image_Picker_dialog.dart';
import 'package:poc_qr/utils/image_picker_util.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScannerAndUpload extends StatefulWidget {
  const QRScannerAndUpload({super.key});

  @override
  State<QRScannerAndUpload> createState() => _QRScannerAndUploadState();
}

class _QRScannerAndUploadState extends State<QRScannerAndUpload> {
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
        backgroundColor: const Color(0XFFE2E4E9),
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'QR Code Scanner',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                    mobileScannerController.toggleTorch();
                  },
                  icon: Icon(
                    Icons.flash_on,
                    color: isFlashOn ? Color(0XFF1439BB) : Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isFrontCamera = !isFrontCamera;
                    });

                    mobileScannerController.switchCamera();
                  },
                  icon: Icon(
                    Icons.flip_camera_ios_outlined,
                    color: isFrontCamera ? Color(0XFF1439BB) : Colors.black,
                  ))
            ]),
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please Scann QR",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        MobileScanner(
                          controller: mobileScannerController,
                          onDetect: (barcode) {
                            if (!isScannCompleted) {
                              isScannCompleted = true;
                              final code = barcode.raw ?? null;

                              if (isFlashOn) {
                                setState(() {
                                  isFlashOn = !isFlashOn;
                                });
                                mobileScannerController.toggleTorch();
                              }

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return QRResult(
                                  code: code!,
                                  type: "QrCode",
                                  closeScanner: () {
                                    closeScreen();
                                  },
                                );
                              }));
                            }
                          },
                        ),
                        QRScannerOverlay(
                            overlayColor: Colors.black45,
                            borderRadius: 20,
                            borderStrokeWidth: 5,
                            scanAreaWidth: 300,
                            scanAreaHeight: 300,
                            borderColor: const Color(0XFF1439BB))
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Container(
                  child: InkWell(
                      onTap: () async {
                        final selection = await showImagePickerDialog(context,
                            closeClick: () {});
                        await handleMediaSelection(selection);
                      },
                      child: const Text("Upload / Capture file")),
                )),
              ],
            )));
  }

  Future handleMediaSelection(
    selection,
  ) async {
    if (selection == null) return null;

    final file = selection == MediaSelection.gallery
        ? await ImagePickerUtil.pickImageFromGallery()
        : await ImagePickerUtil.pickImageFromCamera();

    if (file != null) {
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
