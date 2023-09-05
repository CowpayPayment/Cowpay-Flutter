
import '../../../../core/packages/get_it/get_it.dart';
import '../card_payment_data/card_payment_datasources/card_payment_remote_datasource.dart';
import '../card_payment_data/card_payment_repository/card_payment_repository_impl.dart';
import '../card_payment_domain/card_payment_repositories/card_payment_repository.dart';
import '../card_payment_domain/card_payment_usecases/get_user_cards_usecase.dart';
import '../card_payment_presentation/card_payment_blocs/add_card_bloc/add_card_bloc.dart';
import '../card_payment_presentation/card_payment_blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../card_payment_presentation/card_payment_blocs/webview_bloc/payment_webview_bloc.dart';

final di = GetIt.instance;

class CardPaymentDI {
  CardPaymentDI() {
    call();
  }

  void call() {
    if (!di.isRegistered<CardPaymentRepository>()) {
      di
        ..registerLazySingleton<CardPaymentRepository>(
            () => CardPaymentRepositoryImpl(remoteDataSource: di()))
        ..registerLazySingleton<CardPaymentRemoteDataSource>(
            () => CardPaymentRemoteDataSourceImpl(network: di()))

        //region UseCases
        ..registerLazySingleton(() => GetUserCardsUseCase(
            repository: di())) //endregion

        //region Blocs
        ..registerFactory(() => PaymentWebViewBloc())
        ..registerFactory(() => AddCardBloc(
            getPaymentFeesUseCase: di(),
            payUseCase: di(),
            generateSignatureUseCase: di()))
        ..registerFactory<SavedCardsBloc>(
          () => SavedCardsBloc(
            getPaymentFeesUseCase: di(),
            generateSignatureUseCase: di(),
            payUseCase: di(),
            getUserCardsUseCase: di(),
          ),
        ); //endregion

    }
  }
}
