import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poc_qr/Qr_Scanner/product_listing.dart';
import 'package:poc_qr/models/ocr_result_model.dart';
import 'package:poc_qr/services/apiServices.dart';
import 'package:poc_qr/utils/app_theme.dart';
import 'package:intl/intl.dart';

class QRResult extends StatefulWidget {
  final Object? code;
  final String? image;
  final String type;
  final Function() closeScanner;
  const QRResult(
      {super.key,
      this.image,
      this.code,
      required this.type,
      required this.closeScanner});

  @override
  State<QRResult> createState() => _QRResultState();
}

class _QRResultState extends State<QRResult> {
  Future<List<OCRResultModel>> apiCall(String type) async {
    if (type == "image") {
      final data = imageOCRApiCall(widget.image!, "image");
      return data;
    }
    // else {
    //   final data = jsonDecode(jsonEncode(widget.code));
    //   return Future(() => data[0]["rawValue"]);
    // }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFE2E4E9),
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          // foregroundColor: Colors.black,
          // surfaceTintColor: Colors.blue,
          // scrolledUnderElevation: 10,
          // forceMaterialTransparency: false,
          // elevation: 0.0,
          shadowColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: const Center(
            child: Text(
              'Return Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: widget.image!.isEmpty
            ? const Center(
                child: Text(
                  "Capture / upload product image for return",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : FutureBuilder(
                future: apiCall(widget.type),
                builder:
                    (context, AsyncSnapshot<List<OCRResultModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<OCRResultModel> result = snapshot.requireData;
                    return result.isNotEmpty
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 20.0,
                                  bottom: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.02),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0, -3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Uploaded Image",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.darkText),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              child: Image.file(
                                                File(widget.image!),
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                height: 180,
                                              )),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.02),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0, -3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Product Suggestions",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.darkText),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ProductListing(products: result),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Unable to Find the details please try again",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          );
                  } else {
                    return const Center(
                        child: SpinKitThreeBounce(
                      color: AppTheme.nearlyDarkBlue,
                      size: 30.0,
                    ));
                  }
                }));
  }
}
