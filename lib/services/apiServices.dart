// ignore_for_file: file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poc_qr/models/ocr_result_model.dart';

Future<OCRResultModel> imageOCRApiCall(String filePath, String type) async {
  String username = 'scanner';
  String password = 'troy0k1pxwvdqlb3c751';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  try {
    dio.options.contentType = "multipart/form-data";
    final multiPartFile = await MultipartFile.fromFile(
      filePath,
      filename: filePath.split('/').last,
    );
    FormData formData = FormData.fromMap({
      "file": multiPartFile,
    });

    final response = await dio.post(
      "https://scanner.pharmconnect.com/scan_product",
      options: Options(headers: {
        "Authorization": basicAuth,
        "Content-Type": "multipart/form-data",
      }),
      data: formData,
    );

    if (response.statusCode == 200) {
      if (response.data != null && response.data is List<dynamic>) {
        if (response.data[0]["data"] != null) {
          List<dynamic> prodList = response.data[0]["data"];
          List<Map<String, dynamic>> mapList = [];
          prodList.map((item) {
            mapList.add(item);
          }).toList();
          OCRResultModel dataList = OCRResultModel.fromJson(mapList);
          dataList.outputString = json.encode(response.data[0]);
          return dataList;
        }
      } else if (response.data != null &&
          response.data
              is Map<String, dynamic>) if (response.data["data"] != null) {
        List<dynamic> prodList = response.data["data"];
        List<Map<String, dynamic>> mapList = [];
        prodList.map((item) {
          mapList.add(item);
        }).toList();
        OCRResultModel dataList = OCRResultModel.fromJson(mapList);
        dataList.outputString = json.encode(response.data);
        return dataList;
      }
    }

    return OCRResultModel(
        outputString: json.encode(response.data), products: []);
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectionTimeout) {
      return OCRResultModel(
          outputString: json.encode({"message": "Connection Timeout "}),
          products: []);
    } else if (e.type == DioErrorType.receiveTimeout) {
      return OCRResultModel(
          outputString: json.encode({"message": "Receive Timeout"}),
          products: []);
    } else {
      return OCRResultModel(
          outputString: json.encode({"message": "Network Error"}),
          products: []);
    }
  }
}

Future<OCRResultModel> batchCodeApiCall(String batchCode) async {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  try {
    final response = await dio.get(
      "https://batchinfo.pharmconnect.com/batch/$batchCode",
      options: Options(headers: {
        "Authorization": "Basic YWRtaW46ajR0ZTc3aHowNWxhcHl0aHNiMWc=",
      }),
    );

    if (response.statusCode == 200) {
      if (response.data["data"] != null &&
          response.data["data"] is List<dynamic>) {
        List<dynamic> prodList = response.data["data"];
        List<Map<String, dynamic>> mapList = [];
        prodList.map((item) {
          mapList.add(item);
        }).toList();
        OCRResultModel dataList = OCRResultModel.fromJson(mapList);
        dataList.outputString = json.encode(response.data);
        return dataList;
      } else if (response.data["data"] != null &&
          response.data["data"] is Map<String, dynamic>) {
        List<Map<String, dynamic>> productlst = [response.data["data"]];
        OCRResultModel dataList = OCRResultModel.fromJson(productlst);
        response.data["data"] = productlst;
        dataList.outputString = json.encode(response.data);
        return dataList;
      }
    }

    return OCRResultModel(
        outputString: json.encode(response.data), products: []);
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectionTimeout) {
      return OCRResultModel(
          outputString: json.encode({"message": "Connection Timeout "}),
          products: []);
    } else if (e.type == DioErrorType.receiveTimeout) {
      return OCRResultModel(
          outputString: json.encode({"message": "Receive Timeout"}),
          products: []);
    } else {
      return OCRResultModel(
          outputString: json.encode({"message": "Network Error"}),
          products: []);
    }
  }
}
