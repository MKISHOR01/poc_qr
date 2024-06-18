// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProductListingOld extends StatefulWidget {
  final String searchText;
  const ProductListingOld({super.key, required this.searchText});

  @override
  State<ProductListingOld> createState() => _ProductListingOldState();
}

class _ProductListingOldState extends State<ProductListingOld> {
  List<dynamic> productList = [];
  @override
  void initState() {
    productList.addAll(getProductBySearchText(widget.searchText));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: productList.map(
          (e) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: 4,
                            child: Image.network(
                              e["imgUrl"],
                              width: 500,
                              height: 150,
                            )),
                        Flexible(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${e["displayProductName"]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: "Qty   : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 125, 124, 124),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "${e["qty"]}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 135, 7)))
                                ])),
                                const SizedBox(
                                  height: 3,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: "PTR  : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 125, 124, 124),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "${e["ptr"]}",
                                      style:
                                          const TextStyle(color: Colors.black))
                                ])),
                                const SizedBox(
                                  height: 2,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: "MRP : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 125, 124, 124),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "${e["mrp"]}",
                                      style:
                                          const TextStyle(color: Colors.black))
                                ])),
                              ],
                            ),
                          ),
                        ),
                      ]),
                  Row(
                    children: [
                      const Flexible(
                        flex: 6,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                                focusColor: Colors.grey,
                                hintText: 'Enter Quantity',
                                hintStyle: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 3,
                          child: InkWell(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFF1439BB),
                              ),
                              width: double.infinity,
                              child: const Center(
                                  child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

List<dynamic> getProductBySearchText(String searhText) {
  const data = [
    {
      "productName": "DOLO 650",
      "displayProductName": "DOLO 650MG",
      "qty": 100,
      "ptr": 47.53,
      "mrp": 32.23,
      "imgUrl": "https://m.media-amazon.com/images/I/91bz6RZlHZL.jpg",
    },
    {
      "productName": "DOLOKIND PLUS TAB",
      "displayProductName": "DOLOKIND PLUS TAB",
      "qty": 249,
      "ptr": 27.03,
      "mrp": 18.43,
      "imgUrl":
          "https://www.practostatic.com/practopedia-images/v3/res-750/dolokind-plus-tablet-10-s_d299808f-e6c5-478e-97a2-acaf77e4585c.JPG",
    },
    {
      "productName": "PAN D CAP",
      "displayProductName": "PAN D CAP",
      "qty": 170,
      "ptr": 32.00,
      "mrp": 25.09,
      "imgUrl":
          "https://5.imimg.com/data5/SELLER/Default/2022/1/WT/LO/PP/94476039/pan-d-capsules-500x500.jpg",
    }
  ];
  return data
      .where((element) =>
          element["productName"].toString().toLowerCase() ==
          searhText.toLowerCase())
      .toList();
}
