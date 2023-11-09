import 'package:get/get.dart';
import 'package:getx_boilerplate/data/repository/auth_repository/auth_repository.dart';
import 'package:getx_boilerplate/data/repository/auth_repository/auth_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
      Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
      fenix: true,
    );
  }
}
