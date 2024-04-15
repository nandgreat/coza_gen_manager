import 'dart:convert';

import 'package:coza_gen_manager/data/repositories/auth.dart';
import 'package:coza_gen_manager/data/repositories/keys_repository.dart';
import 'package:coza_gen_manager/models/diesel/DieselLevelResponse.dart';
import 'package:coza_gen_manager/models/diesel/DieselLevelResponse.dart';
import 'package:coza_gen_manager/modules/login/login_screen.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:get/get.dart';

import '../../models/login/login_response.dart' as lg;
import '../../utils/local_storage_helper.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final GeneratorsRepository _generatorsRepository = GeneratorsRepository();
  Rx<lg.Data?> userData = lg.Data().obs;
  RxBool isLoading = false.obs;
  LocalStorageHelper localStorageHelper = LocalStorageHelper();

  Future<void> getUser() async {
    userData.value = await localStorageHelper.getUser();
    logItem("±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±");
    logItem(userData.value!.user!.firstName);
  }

  Future<void> getDieselBalance() async {

    try {
      Response response = await _generatorsRepository.getDieselLevel();

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        var message = DieselLevelResponse
            .fromJson(response.body)
            .message
            .toString();

        lg.Data newUserData = userData.value!;

        newUserData.dieselDetails?.dieselLevel = DieselLevelResponse
            .fromJson(response.body).data?.dieselLevel;


        String userString = jsonEncode(newUserData);

        LocalStorageHelper localStorageHelper = LocalStorageHelper();
        await localStorageHelper.storeItem(key: "user", value: userString);

        getUser();

        isLoading.value = false;

        update();
      } else {
        isLoading.value = false;
        var message = DieselLevelResponse
            .fromJson(response.body)
            .message
            .toString();

        showSnackBar(title: "Error", message: message, type: 'error');
      }
    } catch (e) {
      isLoading.value = false;

      logItem(e);

      showSnackBar(
          title: "Error", message: "Unexpected Error occurred", type: 'error');
    }
  }

  Future<void> logout() async {
    await localStorageHelper.clearAll();
    Get.offAll(const LoginScreen());
  }
}
