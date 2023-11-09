import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '/network/dio_utils.dart';
import '/flavors/environment.dart';
import '/network/pretty_dio_logger.dart';
import '/network/request_headers.dart';
import '/flavors/build_config.dart';


class DioProvider {
  static final String baseUrl = BuildConfig.instance.config.baseUrl;
  static final bool shouldCollectLog =
      BuildConfig.instance.config.shouldCollectLog;

  static Dio? _instance;

  static const int _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: _maxLineWidth,
  );

  static final BaseOptions _options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(
          seconds: BuildConfig.instance.environment == Environment.DEVELOPMENT
              ? 10
              : 200),
      receiveTimeout: Duration(
        seconds: BuildConfig.instance.environment == Environment.DEVELOPMENT
            ? 10
            : 200,
      ));

  static Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_options);
      if (shouldCollectLog) {
        _instance!.interceptors.add(_prettyDioLogger);
      }

      return _instance!;
    } else {
      _instance!.interceptors.clear();
      if (shouldCollectLog) {
        _instance!.interceptors.add(_prettyDioLogger);
      }

      return _instance!;
    }
  }

  ///returns a Dio client with Access token in header
  static Dio get tokenClient {
    _addInterceptors();

    return _instance!;
  }

  ///returns a Dio client with Access token in header
  ///Also adds a token refresh interceptor which retry the request when it's unauthorized
  static Dio get dioWithHeaderToken {
    _addInterceptors();

    return _instance!;
  }

  static _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    _instance!.interceptors.add(RequestHeaderInterceptor());
    _instance!.interceptors.add(DioCacheInterceptor(options: dioCacheOptions));

    if (shouldCollectLog) {
      _instance!.interceptors.add(_prettyDioLogger);
    }
  }

  static String _buildContentType(String version) {
    return "user_defined_content_type+$version";
  }

  DioProvider.setContentType(String version) {
    _instance?.options.contentType = _buildContentType(version);
  }

  DioProvider.setContentTypeApplicationJson() {
    _instance?.options.contentType = "application/json";
  }
}
