import 'package:core/packages/get_it/get_it.dart';
import 'package:network/network.dart';

final di = GetIt.instance;

class NetworkDI {
  NetworkDI() {
    call();
  }

  void call() {
    if (!di.isRegistered<Network>()) {
      di..registerLazySingleton<Network>(() => NetworkUtilImpl())
          // ..registerLazySingleton(() => NetworkService(di()))
          ;
    }
  }
}
