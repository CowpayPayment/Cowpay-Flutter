import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../failures/failures.dart';
import 'request/base_request.dart';
import 'response/response_model.dart';

abstract class Network {
  Future<R> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(dynamic map) responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  });
}

class NetworkUtilImpl implements Network {
  NetworkUtilImpl() {
    _dio.interceptors
        .add(PrettyDioLogger(requestHeader: true, requestBody: true));
  }

  final StatusChecker _statusChecker = StatusChecker();
  final Dio _dio = Dio();

  @override
  Future<R> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(dynamic map) responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  }) async {
    dynamic response;
    try {
      debugPrint(request.headers?["Authorization"]);
      response = await _dio.request(
        request.url,
        data: await request.data,
        queryParameters: await request.queryParameters,
        cancelToken: request.cancelToken,
        onSendProgress: request.requestModel.progressListener?.onSendProgress,
        onReceiveProgress:
            request.requestModel.progressListener?.onReceiveProgress,
        options: Options(
          headers: request.headers,
          method: request.method,
          sendTimeout: request.sendTimeout,
          receiveTimeout: request.receiveTimeout,
        ),
      );
      if (response.data is Map<String, dynamic> &&
          (response.data?.containsKey("errorCode"))) {
        throw Exceptions.serverException(response);
      }
      try {
        return responseFromMap(response.data!);
      } catch (e) {
        throw const ParsingException();
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode != null &&
            _statusChecker(error.response!.statusCode) == HTTPCodes.error) {
          debugPrint((error.response?.statusCode != null &&
                  _statusChecker(error.response!.statusCode) == HTTPCodes.error)
              .toString());
          try {
            if (error.response!.statusCode == 401) {
              throw const Exceptions.authException();
            }
            throw Exceptions.errorException(
              error.response!.statusCode!,
              errorResponseFromMap != null
                  ? errorResponseFromMap(
                      error.response!.data as Map<String, dynamic>)
                  : ErrorMessageResponse.fromMap(
                      error.response?.data is Map<String, dynamic>
                          ? error.response?.data as Map<String, dynamic>
                          : null),
            );
          } catch (exception) {
            rethrow;
          }
        } else {
          throw Exceptions.serverException(error.response!);
        }
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          throw const ConnectionException();
        case DioExceptionType.cancel:
          throw const RequestCanceledException();
        case DioExceptionType.badResponse:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          {
            if (error.message != null) {
              if (error.message!.contains('SocketException')) {
                throw const ConnectionException();
              }
            }
            throw const UnExpectedException();
          }
      }
    } catch (exception) {
      if (exception == ParsingException) {
        rethrow;
      } else {
        throw exception as Exception;
      }
    }
  }
}
