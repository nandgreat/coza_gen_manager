
import 'package:coza_gen_manager/modules/login/login_controller.dart';
import 'package:coza_gen_manager/modules/turn_off_generators/turnoff_generators_controller.dart';
import 'package:get/get.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TurnoffGeneratorsController());
  }
}