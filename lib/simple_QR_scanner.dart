// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:poc_qr/product_Listing.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class SimbleQRscanner extends StatefulWidget {
  const SimbleQRscanner({super.key});

  @override
  State<SimbleQRscanner> createState() => _SimbleQRscannerState();
}

class _SimbleQRscannerState extends State<SimbleQRscanner> {
  String qrResult = '';
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      qrResult = '';
                    });
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SimpleBarcodeScannerPage(
                            isShowFlashIcon: true,
                            appBarTitle: "POC QR scanner",
                            centerTitle: true,
                            lineColor: 'blue',
                            scanType: ScanType.barcode,
                          ),
                        ));
                    setState(() {
                      if (res is String) {
                        qrResult = res != '-1' ? res : '';
                      } else {
                        qrResult = '';
                      }
                    });
                  },
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Color(0XFF1439BB),
                  ),
                ),
              ),
            ]),
        body: Container(
            child: qrResult.isEmpty
                ? const Center(
                    child: Text(
                    "Scan any QR",
                    style: TextStyle(fontSize: 18),
                  ))
                : ProductListingOld(
                    searchText: qrResult,
                  )));
  }
}
