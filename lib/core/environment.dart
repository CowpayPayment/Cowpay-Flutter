import '../domain_models/src/enums/environment_enum.dart';

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
        return 'https://apigateway.cowpay.me';
      case CowpayEnvironment.staging:
        return 'https://sit.cowpay.me';
      default:
        return 'https://sit.cowpay.me';
    }
  }

  static String get tokenUrl {
    switch (environment) {
      case CowpayEnvironment.production:
        return 'https://identity.cowpay.me:8002/GetToken';
      case CowpayEnvironment.staging:
        return 'https://sit.cowpay.me:8000/identity/GetToken';
      default:
        return 'https://sit.cowpay.me:8000/identity/GetToken';
    }
  }

  static String get redirectUrl {
    switch (environment) {
      case CowpayEnvironment.production:
        return 'https://dashboard.cowpay.me:8070/';
      case CowpayEnvironment.staging:
        return gateWayURL;
      default:
        return gateWayURL;
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
