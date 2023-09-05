import 'package:domain_models/domain_models.dart';

class ActiveEnvironment {
  static CowpayEnvironment? environment;

  static String get name => environment?.name ?? '';

  static String get title {
    switch (environment) {
      case CowpayEnvironment.production:
        return 'Cowpay';
      case CowpayEnvironment.staging:
        return 'Cowpay Staging';
      default:
        return 'title';
    }
  }

  static String get baseUrl {
    switch (environment) {
      case CowpayEnvironment.production:
        return 'https://sit.cowpay.me';
      case CowpayEnvironment.staging:
        return 'https://sit.cowpay.me';
      default:
        return 'https://sit.cowpay.me';
    }
  }

  static String get gateWayURL {
    switch (environment) {
      case CowpayEnvironment.production:
        return '$baseUrl:8000';
      case CowpayEnvironment.staging:
        return '$baseUrl:8000';
      default:
        return '$baseUrl:8000';
    }
  }
}
