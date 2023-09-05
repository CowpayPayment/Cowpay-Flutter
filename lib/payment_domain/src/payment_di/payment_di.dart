
import 'package:get_it/get_it.dart';

import '../../payment_domain.dart';
import '../payment_data/payment_datasources/payment_remote_datasource.dart';
import '../payment_data/payment_repository/payment_repository_impl.dart';
import '../payment_domain/payment_repositories/payment_repository.dart';

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
