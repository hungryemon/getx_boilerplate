import 'package:get/get.dart';

import 'controller_bindings.dart';
import 'local_source_bindings.dart';
import 'remote_source_bindings.dart';
import 'repository_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RemoteSourceBindings().dependencies();
    RepositoryBindings().dependencies();
    LocalSourceBindings().dependencies();
    ControllerBindings().dependencies();
  }
}
