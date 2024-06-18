import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:poc_qr/models/ocr_result_model.dart';
import 'package:poc_qr/utils/app_theme.dart';

class ProductListing extends StatefulWidget {
  final List<OCRResultModel> products;
  const ProductListing({super.key, required this.products});

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          children: widget.products.asMap().entries.map((e) {
        final result = e.value;
        // return Container(
        //   margin: const EdgeInsets.symmetric(vertical: 10),
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.black12, width: 0.5),
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.white),
        //   child: ListTile(
        //     title: Text(e.value.productName!),
        //     subtitle: Text(e.value.batchCode!),
        //   ),
        // );

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.productName!,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.nearlyDarkBlue,
                          letterSpacing: 0.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       "Select",
                      //       style: TextStyle(
                      //           fontSize: 16, fontWeight: FontWeight.w500),
                      //     ),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     SizedBox(
                      //       width: 25,
                      //       height: 25,
                      //       child: Checkbox(
                      //         tristate: true,
                      //         value: isChecked,
                      //         checkColor: AppTheme.white,
                      //         activeColor: AppTheme.nearlyDarkBlue,
                      //         onChanged: (bool? value) {
                      //           setState(() {
                      //             isChecked = !isChecked;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      InkWell(
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppTheme.nearlyDarkBlue,
                            ),
                            child: const Text("Select",
                                style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.white,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    letterSpacing: 0.0))),
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Batch Code :",
                      style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(result.batchCode ?? "-",
                        style: const TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 0.0))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Price :",
                            style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(result.price ?? "-",
                              style: const TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                  letterSpacing: 0.0))
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          const Text("Pack Size :",
                              style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  color: Colors.black)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(result.packsize ?? "-",
                              style: const TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                  letterSpacing: 0.0))
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: [
                          const Text(
                            "Mfo. Dt :",
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            result.manufactureDate!.isNotEmpty
                                ? converDateTime(result.manufactureDate!)
                                : "-",
                            style: const TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: Color.fromARGB(255, 36, 91, 65),
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        alignment: WrapAlignment.end,
                        children: [
                          const Text(
                            "Exp Dt :",
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            result.expiryDate!.isNotEmpty
                                ? converDateTime(result.expiryDate!)
                                : "-",
                            style: const TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: Colors.red,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList()),
    );
  }
}

converDateTime(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  String formattedDate =
      DateFormat("dd-MMM-yyyy").format(dateTime).toUpperCase();
  return formattedDate;
}
