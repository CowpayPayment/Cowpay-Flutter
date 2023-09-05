

import 'package:get_it/get_it.dart';

import '../network.dart';

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
