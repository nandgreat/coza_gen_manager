import 'package:coza_gen_manager/controllers/connection_manager_controller.dart';
import 'package:coza_gen_manager/data/repositories/auth.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/signup/SignupRequest.dart';
import '../../models/signup/SignupResponse.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  var isLoading = false.obs;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  ConnectionManagerController connectionManagerController =
      Get.put(ConnectionManagerController());

  Future<void> signup() async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    isLoading.value = true;

    String phoneNumber = phoneController.text.toString();

    phoneNumber = phoneNumber.startsWith("0")
        ? phoneNumber.substring(1, phoneNumber.length - 1)
        : phoneNumber;

    SignupRequest signupRequest = SignupRequest(
        firstName: firstNameController.text.toString(),
        lastName: lastNameController.text.toString(),
        username: usernameController.text.toString(),
        phone: int.parse(phoneNumber),
        email: emailController.text.toString(),
        country: "Nigeria",
        password: passwordController.text.toString());

    try {
      Response response = await _authRepository.signup(signupRequest);

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        var message = SignupResponse.fromJson(response.body).message;

        firstNameController.clear();
        lastNameController.clear();
        usernameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();

        isLoading.value = false;

        showSnackBar(
            title: "Register Success", message: message, type: 'success');

      } else {
        isLoading.value = false;
        var message = SignupResponse.fromJson(response.body).message.toString();

        showSnackBar(title: "Error", message: message, type: 'error');
      }
    } catch (e) {
      isLoading.value = false;

      logItem(e);

      showSnackBar(
          title: "Error", message: "Unexpected Error occurred", type: 'error');
    }
  }

  void validateInput() {}
}
