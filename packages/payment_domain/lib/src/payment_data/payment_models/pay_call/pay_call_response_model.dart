class PayResponseModel {
  String? recurringToken;
  String? tokenId;
  String? redirectUrl;
  RedirectParams? redirectParams;
  RedirectMethod? redirectMethod;
  String? threeDSUrl;
  String? paymentGatewayReferenceId;
  String? merchantReferenceId;
  String? customerReferenceId;
  String? merchantCode;
  String? cowpayReferenceId;
  num? amount;
  num? merchantAmount;
  num? feesAmount;
  num? vatAmount;
  RedirectStatus? status;
  String? paymentMethod;
  int? statusId;
  String? reason;

  PayResponseModel(
      {this.recurringToken,
      this.tokenId,
      this.redirectUrl,
      this.redirectParams,
      this.redirectMethod,
      this.threeDSUrl,
      this.paymentGatewayReferenceId,
      this.merchantReferenceId,
      this.customerReferenceId,
      this.merchantCode,
      this.cowpayReferenceId,
      this.amount,
      this.merchantAmount,
      this.feesAmount,
      this.vatAmount,
      this.status,
      this.paymentMethod,
      this.statusId,
      this.reason});

  PayResponseModel.fromJson(Map<String, dynamic> json) {
    recurringToken = json['recurringToken'];
    tokenId = json['tokenId'];
    redirectUrl = json['redirectUrl'];
    redirectParams = json['redirectParams'] != null
        ? new RedirectParams.fromJson(json['redirectParams'])
        : null;
    redirectMethod = RedirectMethodExtension.parse(json['redirectMethod']);
    status = StatusExtension.parse(json['status']);
    threeDSUrl = json['threeDSUrl'];
    paymentGatewayReferenceId = json['paymentGatewayReferenceId'];
    merchantReferenceId = json['merchantReferenceId'];
    customerReferenceId = json['customerReferenceId'];
    merchantCode = json['merchantCode'];
    cowpayReferenceId = json['cowpayReferenceId'];
    amount = json['amount'];
    merchantAmount = json['merchantAmount'];
    feesAmount = json['feesAmount'];
    vatAmount = json['vatAmount'];
    paymentMethod = json['paymentMethod'];
    statusId = json['statusId'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recurringToken'] = this.recurringToken;
    data['tokenId'] = this.tokenId;
    data['redirectUrl'] = this.redirectUrl;
    if (this.redirectParams != null) {
      data['redirectParams'] = this.redirectParams!.toJson();
    }
    data['redirectMethod'] = this.redirectMethod;
    data['threeDSUrl'] = this.threeDSUrl;
    data['paymentGatewayReferenceId'] = this.paymentGatewayReferenceId;
    data['merchantReferenceId'] = this.merchantReferenceId;
    data['customerReferenceId'] = this.customerReferenceId;
    data['merchantCode'] = this.merchantCode;
    data['cowpayReferenceId'] = this.cowpayReferenceId;
    data['amount'] = this.amount;
    data['merchantAmount'] = this.merchantAmount;
    data['feesAmount'] = this.feesAmount;
    data['vatAmount'] = this.vatAmount;
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    data['statusId'] = this.statusId;
    data['reason'] = this.reason;
    return data;
  }
}

class RedirectParams {
  String? paReq;
  String? redirect;
  String? termUrl;
  String? md;
  String? body;

  RedirectParams({this.paReq, this.redirect, this.termUrl, this.md, this.body});

  RedirectParams.fromJson(Map<String, dynamic> json) {
    paReq = json['paReq'];
    redirect = json['redirect'];
    termUrl = json['termUrl'];
    md = json['md'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paReq'] = this.paReq;
    data['redirect'] = this.redirect;
    data['termUrl'] = this.termUrl;
    data['md'] = this.md;
    data['body'] = this.body;
    return data;
  }
}

enum RedirectStatus {
  threeDS,
  redirect,
  pending,
  paid,
  unpaid,
  expired,
  failed,
  refunded,
  partiallyRefunded
}

extension StatusExtension on RedirectStatus {
  static RedirectStatus? parse(String? status) {
    switch (status) {
      case "REDIRECT":
        return RedirectStatus.redirect;
      case "3DS":
        return RedirectStatus.threeDS;
      case "Pending":
        return RedirectStatus.pending;
      case "Paid":
        return RedirectStatus.paid;
      case "UnPaid":
        return RedirectStatus.unpaid;
      case "Expired":
        return RedirectStatus.expired;
      case "Failed":
        return RedirectStatus.failed;
      case "Refunded":
        return RedirectStatus.refunded;
      case "PartiallyRefunded":
        return RedirectStatus.partiallyRefunded;
    }
  }
}

enum RedirectMethod { post, get }

extension RedirectMethodExtension on RedirectMethod {
  static RedirectMethod? parse(String? method) {
    switch (method) {
      case "POST":
        return RedirectMethod.post;
      case "GET":
        return RedirectMethod.get;
    }
  }
}
