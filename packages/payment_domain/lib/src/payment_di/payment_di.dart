import 'package:core/packages/get_it/get_it.dart';
import 'package:payment_domain/src/payment_domain/payment_usecases/get_payment_fees_usecase.dart';
import 'package:payment_domain/src/payment_domain/payment_usecases/pay_usecase.dart';

import '../payment_data/payment_datasources/payment_remote_datasource.dart';
import '../payment_data/payment_repository/payment_repository_impl.dart';
import '../payment_domain/payment_repositories/payment_repository.dart';
import '../payment_domain/payment_usecases/generate_signature_usecase.dart';

final di = GetIt.instance;

class PaymentDI {
  PaymentDI() {
    call();
  }

  void call() {
    if (!di.isRegistered<PaymentRepository>()) {
      di
        ..registerFactory<PaymentRepository>(
            () => PaymentRepositoryImpl(remoteDataSource: di()))
        ..registerFactory<PaymentRemoteDataSource>(
            () => PaymentRemoteDataSourceImpl(network: di()))
        ..registerFactory(() => GenerateSignatureUseCase())
        ..registerFactory(
          () => GetPaymentFeesUseCase(repository: di()),
        )
        ..registerFactory(
          () => PayUseCase(repository: di()),
        );
    }
  }
}
