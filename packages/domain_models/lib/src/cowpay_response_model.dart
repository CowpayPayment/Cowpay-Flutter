class CowpayResponseModel<T> {
  int? statusCode;
  int? operationStatus;
  String? operationMessage;
  T? data;

  CowpayResponseModel({
    this.statusCode,
    this.operationStatus,
    this.operationMessage,
    this.data,
  });

  CowpayResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic map)? responseFromMap,
  ) {
    statusCode = json['statusCode'];
    operationStatus = json['operationStatus'];
    operationMessage = json['operationMessage'];
    data = responseFromMap!(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['operationStatus'] = this.operationStatus;
    data['operationMessage'] = this.operationMessage;
    data['data'] = this.data;
    return data;
  }
}
