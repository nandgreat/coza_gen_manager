
import 'package:coza_gen_manager/modules/login/login_controller.dart';
import 'package:get/get.dart';

import 'manage_generators_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageGeneratorsController());
  }
}