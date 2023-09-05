class TokenizedCardDetails {
  String? cardNumber;
  String? cardExpMonth;
  String? cardExpYear;
  String? tokenId;

  TokenizedCardDetails(
      {this.cardNumber, this.cardExpMonth, this.cardExpYear, this.tokenId});

  TokenizedCardDetails.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    cardExpMonth = json['cardExpMonth'];
    cardExpYear = json['cardExpYear'];
    tokenId = json['tokenId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cardNumber'] = cardNumber;
    data['cardExpMonth'] = cardExpMonth;
    data['cardExpYear'] = cardExpYear;
    data['tokenId'] = tokenId;
    return data;
  }
}
