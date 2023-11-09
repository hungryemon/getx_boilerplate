import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_boilerplate/data/model/request/login_request.dart';
import 'package:getx_boilerplate/data/model/request/register_request.dart';
import 'package:getx_boilerplate/data/model/response/login_response.dart';
import 'package:getx_boilerplate/data/model/response/register_response.dart';
import 'package:getx_boilerplate/data/model/response/users_response.dart';
import '../../remote/auth_remote/auth_remote_data_source.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteSource =
      Get.find(tag: (AuthRemoteDataSource).toString());

  @override
  Future<UsersResponse?> getUsers() {
    return _remoteSource.getUsers();
  }

  @override
  Future<LoginResponse?> login(LoginRequest data) {
    return _remoteSource.login(data);
  }

  @override
  Future<RegisterResponse?> register(RegisterRequest data) {
    return _remoteSource.register(data);
  }
}
