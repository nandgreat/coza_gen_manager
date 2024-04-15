import 'dart:convert';

import 'package:coza_gen_manager/controllers/connection_manager_controller.dart';
import 'package:coza_gen_manager/data/repositories/auth.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:coza_gen_manager/utils/local_storage_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/login/login_request.dart';
import '../../models/login/login_response.dart';
import '../home/home_screen.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  Data user = Data();
  var isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  ConnectionManagerController connectionManagerController =
      Get.put(ConnectionManagerController());

  Future<void> login() async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    isLoading.value = true;

    LoginRequest loginRequest = LoginRequest(
        email: emailController.text, password: passwordController.text);

    print(loginRequest.toJson());

    try {
      Response response = await _authRepository.login(loginRequest);

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        var user = LoginResponse
            .fromJson(response.body)
            .data;
        String userString = jsonEncode(user);

        LocalStorageHelper localStorageHelper = LocalStorageHelper();
        await localStorageHelper.storeItem(key: "user", value: userString);

        emailController.clear();
        passwordController.clear();
        print(user);
        isLoading.value = false;

        Get.to(HomeScreen());

        update();
      } else {
        isLoading.value = false;
        var message = LoginResponse
            .fromJson(response.body)
            .message
            .toString();

        showSnackBar(title: "Error", message: message, type: 'error');
      }
    }catch(e){
      isLoading.value = false;

      logItem(e);

      showSnackBar(title: "Error", message: "Unexpected Error occurred", type: 'error');

    }
  }

  void validateInput() {}
}
