class FeesModel {
  num? fees;
  num? vatValue;
  FeesModel(this.fees, this.vatValue);
  FeesModel.fromMap(Map<String, dynamic> json) {
    fees = json['feesValue'];
    vatValue = json['vatValue'];
  }
}
