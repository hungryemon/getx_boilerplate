import '../../model/request/login_request.dart';
import '../../model/request/register_request.dart';
import '../../model/response/login_response.dart';
import '../../model/response/register_response.dart';
import '../../model/response/users_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse?> login(LoginRequest data);

  Future<RegisterResponse?> register(RegisterRequest data);

  Future<UsersResponse?> getUsers();
}
