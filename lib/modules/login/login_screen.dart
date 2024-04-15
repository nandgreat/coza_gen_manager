import 'package:coza_gen_manager/components/alternate_login.dart';
import 'package:coza_gen_manager/components/base_screen.dart';
import 'package:coza_gen_manager/components/custom_button.dart';
import 'package:coza_gen_manager/modules/login/login_controller.dart';
import 'package:coza_gen_manager/modules/signup/signup_screen.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_text_input.dart';
import '../../components/float_right_text.dart';
import '../../utils/local_storage_helper.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  handleLogin() {
    hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      loginController.login();
    }
  }

  getUserInfo() async {
    LocalStorageHelper localStorageHelper = LocalStorageHelper();
    String? user = await localStorageHelper.retrieveItem(key: "user");

    logItem(user);

    if (user != null) {
      Get.to(HomeScreen());
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BaseScreen(
          title: "Login",
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SizedBox(
              height: deviceHeight(context),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Enter Email',
                    label: "Email",
                    controller: loginController.emailController,
                    prefixIcon: const Icon(CupertinoIcons.person),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  CustomTextField(
                    hintText: 'Enter Password',
                    label: "Password",
                    controller: loginController.passwordController,
                    obscureText: true,
                    prefixIcon: const Icon(CupertinoIcons.lock),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Obx(() {
                    return CustomButton(
                        label: "Continue",
                        isLoading: loginController.isLoading.value,
                        onPressed: handleLogin);
                  }),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
