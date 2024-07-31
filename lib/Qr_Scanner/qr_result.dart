import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:poc_qr/Qr_Scanner/batch_code_form.dart';
import 'package:poc_qr/Qr_Scanner/product_listing.dart';
import 'package:poc_qr/Qr_Scanner/table_view.dart';
import 'package:poc_qr/models/ocr_result_model.dart';
import 'package:poc_qr/services/apiServices.dart';
import 'package:poc_qr/utils/app_theme.dart';
import 'package:widget_zoom/widget_zoom.dart';

// ignore: must_be_immutable
class QRResult extends StatefulWidget {
  final Object? code;
  String? image;
  String? batchCode;
  String type;
  final Function() closeScanner;
  QRResult(
      {super.key,
      this.image,
      this.batchCode,
      this.code,
      required this.type,
      required this.closeScanner});

  @override
  State<QRResult> createState() => _QRResultState();
}

class _QRResultState extends State<QRResult> {
  String type = "";
  String reqValue = "";

  Future<OCRResultModel> apiCall() async {
    if (type == "image") {
      final data = imageOCRApiCall(reqValue, "image");
      return data;
    } else if (type == "batchCode") {
      final data = batchCodeApiCall(reqValue);
      return data;
    }

    return OCRResultModel(products: [], outputString: "");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      type = widget.type;
      reqValue = type == "image" ? widget.image ?? "" : widget.batchCode ?? "";
    });

    return Scaffold(
        backgroundColor: const Color(0XFFE2E4E9),
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
        body: reqValue.isEmpty
            ? const Center(
                child: Text(
                  "Capture / upload product image for return",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : FutureBuilder(
                future: apiCall(),
                builder: (context, AsyncSnapshot<OCRResultModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    OCRResultModel result = snapshot.requireData;
                    return result.products.length > 0
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
                                  type == "image"
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.02),
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
                                                child: WidgetZoom(
                                                  heroAnimationTag: 'tag',
                                                  zoomWidget: Image.file(
                                                    File(widget.image!),
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    height: 180,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      : type == "batchCode"
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.02),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: const Offset(0, -3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Flexible(
                                                    flex: 4,
                                                    child: Text(
                                                      "Batch Code :",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppTheme
                                                              .darkText),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    flex: 5,
                                                    child: Text(
                                                      reqValue.toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: AppTheme
                                                              .nearlyDarkBlue),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          : Container(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      // height: 400,
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
                                          result.products.length > 0 != null
                                              ? const Text(
                                                  "Product Suggestions",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppTheme.darkText),
                                                )
                                              : Container(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          result.products.length > 0 != null
                                              ? ProductListing(
                                                  products: result.products)
                                              : Container(),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          result.products.length > 0
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  child: Text(
                                                    "API Response",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Container(),
                                          result.outputString != ""
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 2.0,
                                                      vertical: 5.0),
                                                  child: APIResponseTableView(
                                                    data: json.decode(
                                                        result.outputString ??
                                                            ""),
                                                  ))
                                              : Container(),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Text(
                                    "Unable to Find the details please try again / Enter the Batch Code to find the details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BatchCodeForm(
                                  onSubmit: (value) {
                                    setState(() {
                                      widget.batchCode = value;
                                      widget.type = "batchCode";
                                      widget.image = "";
                                      apiCall();
                                    });
                                  },
                                ),
                                result.products.length > 0 ||
                                        result.outputString != ""
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "API Response",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Container(),
                                result.outputString != ""
                                    ? APIResponseTableView(
                                        data: json
                                            .decode(result.outputString ?? ""),
                                      )
                                    // Padding(
                                    //     padding: const EdgeInsets.all(10),
                                    //     child: Text(getjsonObjecDisplay(
                                    //         result[0].outputString ?? "")),
                                    //   )
                                    : Container(),
                                SizedBox(
                                  height: 100,
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

String getjsonObjecDisplay(String jsonString) {
  Map<String, dynamic> user = json.decode(jsonString);
  String prettyJson = JsonEncoder.withIndent('  ').convert(user);

  return prettyJson;
}
