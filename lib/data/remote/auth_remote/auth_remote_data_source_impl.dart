// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import '../../../helper/process_object.dart';
import '../../model/request/login_request.dart';
import '../../model/request/register_request.dart';
import '../../model/response/login_response.dart';
import '../../model/response/register_response.dart';
import '../../model/response/users_response.dart';
import '/app/base/base_remote_source.dart';
import '/network/dio_provider.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl extends BaseRemoteSource
    implements AuthRemoteDataSource {

@override
Future<LoginResponse?> login(LoginRequest data) {
    var endpoint = "${DioProvider.baseUrl}/api/login";
    final dioCall = dioClient.post(endpoint, data: processObject(data.toJson()));
     try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

   _parseLoginResponse(Response<dynamic> response) {
    return LoginResponse.fromJson(response.data);

  }

@override
  Future<RegisterResponse?> register(RegisterRequest data) async {
     var endpoint = "${DioProvider.baseUrl}/api/register";
    final dioCall = dioClient.post(endpoint, data: processObject(data.toJson()));
     try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseRegisterResponse(response));
    } catch (e) {
      rethrow;
    }
  }

   _parseRegisterResponse(Response<dynamic> response) {
    return RegisterResponse.fromJson(response.data);

  }

  @override
  Future<UsersResponse?> getUsers() async {

  var endpoint = "${DioProvider.baseUrl}/api/users?page=1&per_page=12";
    final dioCall = dioClient.get(endpoint,);
     try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseUsersResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  _parseUsersResponse(Response<dynamic> response) {
    return UsersResponse.fromJson(response.data);

  }
}
