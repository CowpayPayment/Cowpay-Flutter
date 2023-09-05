// import 'package:auth/src/auth_data/auth_models/login_call_models/login_call_request_model.dart';
// import 'package:auth/src/auth_data/auth_models/login_call_models/login_call_response_model.dart';
// import 'package:core/packages/dartz/flutter_toast.dart';
// import 'package:core/usecase/usecase.dart';
// import 'package:form_fields/form_fields.dart';
// import 'package:network/network.dart';
//
// import '../auth_repositories/auth_repository.dart';
//
// class LoginUseCase implements UseCase<LoginResponseModel, LoginUseCaseParams> {
//   final AuthRepository repository;
//
//   LoginUseCase({required this.repository});
//
//   @override
//   Future<Either<Failure, LoginResponseModel>> call(
//       LoginUseCaseParams params) async {
//     Either<Failure, LoginResponseModel> marketsResponse =
//         await repository.loginCall(
//             requestModel: LoginRequestModel(
//                 username: params.username, password: params.password));
//     return marketsResponse;
//   }
// }
//
// class LoginUseCaseParams {
//   final Email username;
//   final Password password;
//
//   LoginUseCaseParams({required this.username, required this.password});
// }
