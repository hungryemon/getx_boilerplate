import 'package:get/get.dart';
import 'package:getx_boilerplate/data/remote/auth_remote/auth_remote_data_source.dart';
import 'package:getx_boilerplate/data/remote/auth_remote/auth_remote_data_source_impl.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
      Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
      tag: (AuthRemoteDataSource).toString(),
      fenix: true,
    );
  }
}
