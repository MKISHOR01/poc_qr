import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poc_qr/models/ocr_result_model.dart';

Future<List<OCRResultModel>> imageOCRApiCall(
    String filePath, String type) async {
  String username = 'scanner';
  String password = 'troy0k1pxwvdqlb3c751';
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$username:$password'));

  final dio = Dio();
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
    if (response.data["data"] != null) {
      final List<OCRResultModel> dataList = [];
      dataList.add(OCRResultModel.fromJson(response.data["data"]));
      return dataList;
    }
  }

  return [];
}

Future<List<OCRResultModel>> batchCodeApiCall(String batchCode) async {
  final dio = Dio();

  final response = await dio.get(
    "https://batchinfo.pharmconnect.com/batch/$batchCode",
    options: Options(headers: {
      "Authorization": "Basic YWRtaW46ajR0ZTc3aHowNWxhcHl0aHNiMWc=",
    }),
  );

  if (response.statusCode == 200) {
    if (response.data["data"] != null) {
      final List<OCRResultModel> dataList = [];
      dataList.add(OCRResultModel.fromJson(response.data["data"]));
      return dataList;
    }
  }

  return [];
}
