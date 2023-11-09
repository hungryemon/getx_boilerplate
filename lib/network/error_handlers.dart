import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '/network/exceptions/api_exception.dart';
import '/network/exceptions/app_exception.dart';
import '/network/exceptions/network_exception.dart';
import '/network/exceptions/not_found_exception.dart';
import '/network/exceptions/service_unavailable_exception.dart';
import '/flavors/build_config.dart';

Exception handleError(String error) {
  final logger = BuildConfig.instance.config.logger;
  logger.e("Generic exception: $error");

  return AppException(message: error);
}

Exception handleDioError(DioException dioException) {
  switch (dioException.type) {
    case DioExceptionType.cancel:
      return AppException(message: "Request to API server was cancelled");
    case DioExceptionType.connectionTimeout:
      return AppException(message: "Connection timeout with API server");
    case DioExceptionType.connectionError:
      return NetworkException("There is no internet connection");
    case DioExceptionType.receiveTimeout:
      return TimeoutException("Receive timeout in connection with API server");
    case DioExceptionType.sendTimeout:
      return TimeoutException("Send timeout in connection with API server");
    case DioExceptionType.badCertificate:
      return const CertificateException("Certificate error");
    case DioExceptionType.unknown : 
      return AppException(message:  " Unknown error occured");
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(dioException);
  }
}

Exception _parseDioErrorResponse(DioException dioException) {
  final logger = BuildConfig.instance.config.logger;

  int statusCode = dioException.response?.statusCode ?? -1;
  String? status;
  String? serverMessage;

  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioException.response?.data["statusCode"];
    }
    status = dioException.response?.data["status"];
    serverMessage = dioException.response?.data["msg"];
  } catch (e, s) {
    logger.i("$e");
    logger.i(s.toString());

    serverMessage = "Something went wrong. Please try again later.";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? "", status ?? "");
    default:
      return ApiException(
        httpCode: statusCode,
        status: status ?? "",
        message: serverMessage ?? "",
      );
  }
}
