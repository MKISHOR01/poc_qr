class OCRResultModel {
  final List<OCRDataList> products;
  String? outputString;

  OCRResultModel({required this.products, this.outputString});

  factory OCRResultModel.fromJson(List<Map<String, dynamic>> products) {
    return OCRResultModel(
      products: products.map((data) => OCRDataList.fromJson(data)).toList(),
      outputString: "",
    );
  }
}

class OCRDataList {
  final String? workspaceId;
  final String? batchCode;
  final String? expiryDate;
  final String? manufactureDate;
  final String? productName;
  final String? productVariantId;
  final String? price;
  final String? packsize;
  final String? headDivisionCode;
  final String? divisionCode;
  String? outputString;

  OCRDataList(
      {this.workspaceId,
      this.batchCode,
      this.expiryDate,
      this.manufactureDate,
      this.productName,
      this.productVariantId,
      this.price,
      this.packsize,
      this.headDivisionCode,
      this.outputString,
      this.divisionCode});

  factory OCRDataList.fromJson(Map<String, dynamic> json) {
    return OCRDataList(
      workspaceId: json["workspaceId"] ?? "",
      batchCode: json["batchCode"] ?? "",
      expiryDate: json["expiryDate"] ?? "",
      manufactureDate: json["manufactureDate"] ?? "",
      productName: json["productName"] ?? "",
      productVariantId: json["productVariantId"].toString(),
      price: json["price"] ?? "",
      packsize: json["packsize"].toString(),
      headDivisionCode: json["headDivisionCode"] ?? "",
      divisionCode: json["divisionCode)"] ?? "",
    );
  }
}
