
import 'package:get_it/get_it.dart';

import '../payment_methods_data/payment_methods_datasources/payment_methods_datasource.dart';
import '../payment_methods_data/payment_methods_repository/payment_methods_repository_impl.dart';
import '../payment_methods_domain/payment_methods_repositories/payment_methods_repository.dart';
import '../payment_methods_domain/payment_methods_usecases/get_payment_methods_usecase.dart';
import '../payment_methods_domain/payment_methods_usecases/get_token_usecase.dart';
import '../payment_methods_presentation/payment_methods_bloc/payment_methods_bloc.dart';

final di = GetIt.instance;

class PaymentMethodsDI {
  PaymentMethodsDI() {
    call();
  }

  void call() {
    if (!di.isRegistered<PaymentMethodsRepository>()) {
      di
        ..registerLazySingleton<PaymentMethodsRepository>(
            () => PaymentMethodsRepositoryImpl(remoteDataSource: di()))
        ..registerLazySingleton<PaymentMethodsRemoteDataSource>(
            () => PaymentMethodsRemoteDataSourceImpl(network: di()))
        ..registerLazySingleton<GetTokenUseCase>(
            () => GetTokenUseCase(repository: di()))
        ..registerLazySingleton<GetPaymentMethodsUseCase>(
            () => GetPaymentMethodsUseCase(repository: di()))
        ..registerFactory<PaymentMethodsBloc>(() => PaymentMethodsBloc(
              getTokenUseCase: di(),
              getPaymentMethodsUseCase: di(),
            ));
    }
  }
}
