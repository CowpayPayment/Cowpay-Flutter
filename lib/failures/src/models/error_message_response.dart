
import '../../../network/network.dart';

class ErrorMessageResponse extends ResponseModel {
  ErrorMessageResponse({required this.message, this.errors});

  factory ErrorMessageResponse.fromMap(Map<String, dynamic>? map) {
    var errors = <String>[];
    if (map?['error'] != null) {
      map?['error'].forEach((v) {
        errors.add(v);
      });
    }
    return ErrorMessageResponse(
      message: map?['message'] as String? ??
          map?['msg'] as String? ??
          map?['operationMessage'] as String? ??
          map?['error_description'] as String? ??
          map?['errorCode'] ??
          "somethingWentWrong",
      errors: errors,
    );
  }

  final String message;
  final List<String>? errors;

  @override
  List<Object?> get props => [message];

  Map<String, dynamic> toMap() {
    return {'message': message};
  }
}
