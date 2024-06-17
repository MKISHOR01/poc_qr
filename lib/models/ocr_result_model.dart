class OCRResultModel {
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

  OCRResultModel(
      {this.workspaceId,
      this.batchCode,
      this.expiryDate,
      this.manufactureDate,
      this.productName,
      this.productVariantId,
      this.price,
      this.packsize,
      this.headDivisionCode,
      this.divisionCode});

  factory OCRResultModel.fromJson(Map<String, dynamic> json) {
    return OCRResultModel(
      workspaceId: json["workspaceId"] ?? "",
      batchCode: json["batchCode"] ?? "",
      expiryDate: json["expiryDate"] ?? "",
      manufactureDate: json["manufactureDate"] ?? "",
      productName: json["productName"] ?? "",
      productVariantId: json["productVariantId"].toString() ?? "",
      price: json["price"] ?? "",
      packsize: json["packsize"].toString() ?? "",
      headDivisionCode: json["headDivisionCode"] ?? "",
      divisionCode: json["divisionCode)"] ?? "",
    );
  }
}
