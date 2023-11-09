import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '/data/local/preference/preference_manager.dart';
import '../helper/custom_navigation.dart';
import '/network/dio_provider.dart';
import '/routes/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  String _buildNumber = "-1";
  String _buildVersion = "-1";
  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());

  final Dio dio = Dio();

  RequestHeaderInterceptor() {
    updateBuildNumber();
  }

  void updateBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _buildNumber = packageInfo.buildNumber;
    _buildVersion = packageInfo.version;
  }

  Map<String, String> getAdditionalHeaders() {
    return {
      'x-app': Platform.isAndroid
          ? 'com.getx_boilerplate.android'
          : Platform.isWindows
              ? 'com.getx_boilerplate.windows'
              : Platform.isLinux
                  ? 'com.getx_boilerplate.linux'
                  : Platform.isMacOS
                      ? 'com.getx_boilerplate.macos'
                      : Platform.isIOS
                          ? 'ccom.getx_boilerplate.ios'
                          : Platform.isFuchsia
                              ? 'com.getx_boilerplate.fuchsia'
                              : 'com.getx_boilerplate.web',
      'x-app-version': _buildVersion,
      'x-app-build': _buildNumber,
    };
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Response<dynamic>> _cloneDioErrorRequestWithAccesstoken(
    DioException err,
    String accessToken,
  ) {
    err.requestOptions.headers["accesstoken"] = accessToken;
    //create request with new access token
    final opts = Options(
      method: err.requestOptions.method,
      headers: err.requestOptions.headers,
    );
    return dio.request(
      err.requestOptions.path,
      options: opts,
      data: err.requestOptions.data,
      queryParameters: err.requestOptions.queryParameters,
    );
  }

  @override
  void onError(err, handler) async {
    if (err.response?.statusCode == 401) {
      final prefAccessToken = await _preferenceManager.getAccessToken();
      try {
        String? errAccessToken = err.requestOptions.headers["accesstoken"];
        if (errAccessToken != null &&
            errAccessToken.isNotEmpty &&
            prefAccessToken == errAccessToken) {
          await _preferenceManager.updateTokens(
              accessToken: null, accessTokenExp: null);
        }
        var value = await dio.post(
          "${DioProvider.baseUrl}/user/refresh-token",
          options: Options(
            headers: {
              'refreshtoken': await _preferenceManager.getRefreshToken(),
              ...getAdditionalHeaders(),
            },
          ),
        );
        if (value.statusCode == 201 || value.statusCode == 200) {
          var data = value.data["data"];
          var accessToken = data["accessToken"];
          var refreshToken = data["refreshToken"];
          var accessTokenExp = data["accessTokenExp"];
          await _preferenceManager.updateTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
            accessTokenExp: accessTokenExp,
          );

          
          /*
          TODO: Refetch User Data Here
          */

          return handler.resolve(
              await _cloneDioErrorRequestWithAccesstoken(err, accessToken));
        } else {
          throw "";
        }
      } catch (e) {
        /** 
         * Means refresh token is invalid!
         * But, there is a possibility of concurrent refresh-token api call
         * So, let's check if access token is there!
         * */
        if (prefAccessToken.isEmpty) {
          /** Means accesstoken (or, new accesstoken in parallel case) and refreshtoken both are expired */
          await _preferenceManager.updateTokens(
            accessToken: null,
            refreshToken: null,
            accessTokenExp: null,
          );

          /*
          TODO: Refetch User Data Here
          */
          await goToNamedAndClearAll(AppRoutes.SPLASH);
        } else {
          /** Means new accesstoken is not expired */
          return handler.resolve(
              await _cloneDioErrorRequestWithAccesstoken(err, prefAccessToken));
        }
      }
    } else {
      super.onError(err, handler);
    }
  }

  Future<Map<String, String>> getCustomHeaders() async {
    var accessToken = await _preferenceManager.getAccessToken();

    var customHeaders = {
      'content-type': 'application/json',
      'accesstoken': accessToken,
      ...getAdditionalHeaders(),
    };

    return customHeaders;
  }
}
