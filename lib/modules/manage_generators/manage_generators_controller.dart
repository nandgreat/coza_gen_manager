import 'package:coza_gen_manager/models/turnon_generator/turn_on_gen_request.dart';
import 'package:coza_gen_manager/models/turnon_generator/turn_on_gen_response.dart';
import 'package:coza_gen_manager/modules/home/home_screen.dart';
import 'package:coza_gen_manager/modules/login/login_screen.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../controllers/connection_manager_controller.dart';
import '../../data/repositories/keys_repository.dart';
import '../../models/generators/generator_list_response.dart';
import '../../models/approval_admins/approval_admin_response.dart' as ad;
import '../../models/generators/generator_purpose_response.dart' as purpose;
import '../../utils/local_storage_helper.dart';
import 'package:coza_gen_manager/models/generators/generator_list_response.dart' as gen;

class ManageGeneratorsController extends GetxController {
  final GeneratorsRepository _generatorsRepository = GeneratorsRepository();
  var genList = <String>[].obs;
  var keys = <gen.Data>[].obs;
  var purposeId = "".obs;
  var adminId = "".obs;
  var selectedGens = <String>[].obs;
  var selectedLoads = <String>[].obs;

  var purposes = <purpose.Data>[].obs;
  var admins = <ad.Data>[].obs;
  var purposeList = <String>[].obs;
  var adminList = <String>[].obs;
  var loads = ['Auditorium', 'Basement'];
  var isLoading = false.obs;
  var isPurposeLoading = false.obs;
  var isAdminLoading = false.obs;
  var isSubmitting = false.obs;
  LocalStorageHelper localStorageHelper = LocalStorageHelper();

  // var passwordController = TextEditingController();

  var workerCodeController = TextEditingController();
  var purposeController = TextEditingController();
  var adminController = TextEditingController();

  ConnectionManagerController connectionManagerController =
  Get.put(ConnectionManagerController());

  Future<void> getGenerators(String type) async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    isLoading.value = true;

    try {
      Response response = await _generatorsRepository.getGenerators();

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        if (type == "pick") {
          keys.value = GeneratorListResponse
              .fromJson(response.body)
              .data!
              .where((element) => element.statusId == 1)
              .toList();
        } else {
          keys.value = GeneratorListResponse
              .fromJson(response.body)
              .data!
              .where((element) => element.statusId == 2)
              .toList();
        }

        keys.forEach((element) {
          genList.add(element.generatorName!);
        });

        var message =
        GeneratorListResponse
            .fromJson(response.body)
            .message
            .toString();

        isLoading.value = false;

        update();
      } else {
        isLoading.value = false;
        var message =
        GeneratorListResponse
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

  Future<void> getPurposes() async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    isPurposeLoading.value = true;

    try {
      Response response = await _generatorsRepository.getGeneratorPurposes();

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        purposes.value =
            purpose.GeneratorPurposeResponse
                .fromJson(response.body)
                .data!
                .toList();

        purposes.forEach((element) {
          purposeList.add(element.generatorPurpose!);
        });

        var message = purpose.GeneratorPurposeResponse
            .fromJson(response.body)
            .message
            .toString();

        isPurposeLoading.value = false;

        update();
      } else {
        isPurposeLoading.value = false;
        var message =
        GeneratorListResponse
            .fromJson(response.body)
            .message
            .toString();

        showSnackBar(title: "Error", message: message, type: 'error');
      }
    } catch (e) {
      isPurposeLoading.value = false;

      logItem(e);

      showSnackBar(
          title: "Error", message: "Unexpected Error occurred", type: 'error');
    }
  }

  Future<void> getAdmins() async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    isAdminLoading.value = true;

    try {
      Response response = await _generatorsRepository.getAdmins();

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        admins.value =
            ad.ApprovalAdminResponse
                .fromJson(response.body)
                .data!
                .toList();

        admins.forEach((element) {
          adminList.add(element.approvalAdmin!);
        });

        var message =
        ad.ApprovalAdminResponse
            .fromJson(response.body)
            .message
            .toString();

        isAdminLoading.value = false;

        update();
      } else {
        isAdminLoading.value = false;
        var message =
        GeneratorListResponse
            .fromJson(response.body)
            .message
            .toString();

        showSnackBar(title: "Error", message: message, type: 'error');
      }
    } catch (e) {
      isAdminLoading.value = false;
      logItem(e);
      showSnackBar(
          title: "Error", message: "Unexpected Error occurred", type: 'error');
    }
  }


  Future<void> logout() async {
    await localStorageHelper.clearAll();
    Get.offAll(const LoginScreen());
  }

  Future<void> turnOnGenerator() async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    isLoading.value = true;

    var validGens = <num>[];

    selectedGens.forEach((el) {
     var newElement = keys.firstWhere((element) => element.generatorName == el);
     validGens.add(newElement.id!);
    });

    logItem(selectedLoads.join(','));

    TurnOnGenRequest turnOnGenRequest = TurnOnGenRequest(
        approvedBy: num.parse(adminId.value),
        workerCode: workerCodeController.text,
        generators: validGens,
        generatorLoad: selectedLoads.join(','),
        generatorPurposeId: num.parse(purposeId.value));

    try {
      Response response = await _generatorsRepository.turnOnGen(
          turnOnGenRequest);

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        var message = TurnOnGenResponse
            .fromJson(response.body)
            .message
            .toString();

        showSnackBar(title: "Success", message: message, type: 'success');

        isLoading.value = false;
        workerCodeController.clear();

        Get.off(HomeScreen());

        update();
      } else {
        isLoading.value = false;
        var message = TurnOnGenResponse
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
}
