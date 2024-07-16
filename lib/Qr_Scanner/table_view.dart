import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class APIResponseTableView extends StatefulWidget {
  final Map<String, dynamic>? data;
  const APIResponseTableView({super.key, this.data});

  @override
  State<APIResponseTableView> createState() => _APIResponseTableViewState();
}

class _APIResponseTableViewState extends State<APIResponseTableView> {
  @override
  Widget build(BuildContext context) {
    return widget.data!.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: _buildTableRows(widget.data!),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.data!["data"] != null
                    ? Text("Data",
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : Row(
                        children: [
                          Text("Data :",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.data!["data"].toString()),
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                widget.data!["data"] != null
                    ? Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'workspaceId',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]["workspaceId"]
                                    .toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'batchCode',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]["batchCode"]
                                    .toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'expiryDate',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(converDateTime(widget.data!["data"]
                                        ["expiryDate"]
                                    .toString())),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'manufactureDate',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(converDateTime(widget.data!["data"]
                                        ["manufactureDate"]
                                    .toString())),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'productName',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]["productName"]
                                    .toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'productVariantId',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]
                                        ["productVariantId"]
                                    .toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'price',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                    widget.data!["data"]["price"].toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'packsize',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]["packsize"]
                                    .toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'headDivisionCode',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]
                                        ["headDivisionCode"]
                                    .toString()),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'divisionCode',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(widget.data!["data"]["divisionCode"]
                                    .toString()),
                              ),
                            ),
                          ]),
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        : Container(
            child: Text("Empty Response",
                style: TextStyle(fontWeight: FontWeight.bold)));
  }
}

converDateTime(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  String formattedDate =
      DateFormat("dd-MMM-yyyy").format(dateTime).toUpperCase();
  return formattedDate;
}

List<TableRow> _buildTableRows(Map<String, dynamic> data) {
  List<TableRow> rows = [];
  if (data!["start_time_seconds"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'start_time_seconds',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["start_time_seconds"].toString()),
        ),
      ),
    ]));
  }
  if (data!["end_time_seconds"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'end_time_seconds',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["end_time_seconds"].toString()),
        ),
      ),
    ]));
  }
  if (data!["duration_seconds"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'duration_seconds',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["duration_seconds"].toString()),
        ),
      ),
    ]));
  }

  if (data!["status"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["status"].toString()),
        ),
      ),
    ]));
  }

  if (data!["ocr_duration_seconds"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'ocr_duration_seconds',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["ocr_duration_seconds"].toString()),
        ),
      ),
    ]));
  }

  if (data!["message"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'message',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["message"].toString()),
        ),
      ),
    ]));
  }

  if (data!["accuracy"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'accuracy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["accuracy"].toString()),
        ),
      ),
    ]));
  }

  if (data!["batch_number"] != null) {
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'BatchNumber',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(data!["batch_number"].toString()),
        ),
      ),
    ]));
  }

  if (data!["ocr_output"] != null) {
    String value = data!["ocr_output"].toString().replaceAll("\n", " ");
    rows.add(TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'ocr_output',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(value),
        ),
      ),
    ]));
  }

  return rows;
}
