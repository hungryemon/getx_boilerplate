import 'package:dio/dio.dart';


import '/network/dio_provider.dart';
import '/network/error_handlers.dart';
import '/network/exceptions/base_exception.dart';
import '/flavors/build_config.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  final logger = BuildConfig.instance.config.logger;

       

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {

    try {
      Response<T> response = await api;
     
      // if (response.statusCode != HttpStatus.ok ||
      //     (response.data as Map<String, dynamic>)['statusCode'] !=
      //         HttpStatus.ok) {}

      return response;
    } on DioException catch (dioException) {
      Exception exception = handleDioError(dioException);
      logger.e(
          "Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");
      throw handleError(exception.message);
    } catch (error) {
      logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
