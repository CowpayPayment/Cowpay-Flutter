import '../../../../core/packages/get_it/get_it.dart';
import '../fawry_payment_data/fawry_payment_datasources/fawry_payment_remote_datasource.dart';
import '../fawry_payment_data/fawry_payment_repository/fawry_payment_repository_impl.dart';
import '../fawry_payment_domain/fawry_payment_repositories/fawry_payment_repository.dart';
import '../fawry_payment_presentation/fawry_payment_blocs/fawry_bloc/fawry_bloc.dart';

final di = GetIt.instance;

class FawryPaymentDI {
  FawryPaymentDI() {
    call();
  }

  void call() {
    if (!di.isRegistered<FawryPaymentRepository>()) {
      di
        ..registerFactory<FawryPaymentRepository>(
            () => FawryPaymentRepositoryImpl(remoteDataSource: di()))
        ..registerFactory<FawryPaymentRemoteDataSource>(
            () => FawryPaymentRemoteDataSourceImpl(network: di()))
        ..registerFactory<FawryBloc>(() => FawryBloc(
            getPaymentFeesUseCase: di(),
            generateSignatureUseCase: di(),
            payUseCase: di()));
    }
  }
}
