import 'dart:io';

import 'package:coza_gen_manager/models/refuel_generator/Refuel_generator_request.dart';
import 'package:coza_gen_manager/models/refuel_generator/refuel_generator_response.dart';

import 'package:coza_gen_manager/modules/home/home_screen.dart';
import 'package:coza_gen_manager/modules/login/login_screen.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controllers/connection_manager_controller.dart';
import '../../data/repositories/keys_repository.dart';
import '../../models/Upload_image_response.dart';
import '../../models/generators/generator_list_response.dart';
import '../../models/approval_admins/approval_admin_response.dart' as ad;
import '../../models/generators/generator_purpose_response.dart' as purpose;
import '../../utils/local_storage_helper.dart';
import 'package:coza_gen_manager/models/generators/generator_list_response.dart'
    as gen;

class RefuelGeneratorsController extends GetxController {
  final GeneratorsRepository _generatorsRepository = GeneratorsRepository();
  var genList = <String>[].obs;
  var activeGenList = <String>[].obs;
  var keys = <gen.Data>[].obs;
  var purposeId = "".obs;
  var genLevelBeforeImage = "".obs;
  var genLevelBeforeImageLoading = false.obs;
  var genLevelAfterImage = "".obs;
  var genLevelAfterImageLoading = false.obs;
  var invoiceImage = "".obs;
  var invoiceImageLoading = false.obs;
  var wayBillImage = "".obs;
  var wayBillImageLoading = false.obs;
  var adminId = "".obs;
  var selectedGens = [].obs;
  var selectedLoads = [].obs;

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
  var confirmationWorkerCodeController = TextEditingController();
  var purposeController = TextEditingController();
  var adminController = TextEditingController();
  var dieselLevelController = TextEditingController();

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
          keys.value = GeneratorListResponse.fromJson(response.body)
              .data!
              .where((element) => element.statusId == 1)
              .toList();
        } else {
          keys.value = GeneratorListResponse.fromJson(response.body)
              .data!
              .where((element) => element.statusId == 2)
              .toList();
        }

        keys.forEach((element) {
          genList.add(element.generatorName!);
        });

        var message =
            GeneratorListResponse.fromJson(response.body).message.toString();

        isLoading.value = false;

        update();
      } else {
        isLoading.value = false;
        var message =
            GeneratorListResponse.fromJson(response.body).message.toString();

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

  Future<void> turnOnGenerator() async {
    RxInt idFromFirstController = connectionManagerController.connectionType;

    if (idFromFirstController.value == 0) {
      showNoInternetSnackBar();
      return;
    }

    if (genLevelBeforeImage.value.isEmpty) {
      showSnackBar(
          title: "Error",
          message: "Diesel Level Before Image is required",
          type: 'error');
      return;
    }
    if (genLevelAfterImage.value.isEmpty) {
      showSnackBar(
          title: "Error",
          message: "Diesel Level After Image is required",
          type: 'error');
      return;

    }
    if (invoiceImage.value.isEmpty) {
      showSnackBar(
          title: "Error",
          message: "Invoice Image is required",
          type: 'error');
      return;

    }
    if (wayBillImage.value.isEmpty) {
      showSnackBar(
          title: "Error",
          message: "Waybill Image is required",
          type: 'error');
      return;

    }

    isLoading.value = true;

    RefuelGeneratorRequest refuelGenerator = RefuelGeneratorRequest(
        quantity: int.parse(dieselLevelController.text),
        workerCode: workerCodeController.text,
        confirmationWorkerCode: confirmationWorkerCodeController.text,
        dieselBeforeImageUrl: genLevelBeforeImage.value,
        dieselAfterImageUrl: genLevelAfterImage.value,
        invoiceImageUrl: invoiceImage.value,
        waybillImageUrl: wayBillImage.value);

    try {
      Response response =
          await _generatorsRepository.refuelGen(refuelGenerator);

      // ignore: unrelated_type_equality_checks
      if (response.isOk) {
        var message =
            RefuelGeneratorResponse.fromJson(response.body).message.toString();

        showSnackBar(title: "Success", message: message, type: 'success');

        isLoading.value = false;
        workerCodeController.clear();

        Get.off(HomeScreen());

        update();
      } else {
        isLoading.value = false;
        var message =
            RefuelGeneratorResponse.fromJson(response.body).message.toString();

        showSnackBar(title: "Error", message: message, type: 'error');
      }
    } catch (e) {
      isLoading.value = false;

      logItem(e);

      showSnackBar(
          title: "Error", message: "Unexpected Error occurred", type: 'error');
    }
  }

  void uploadImage(
      {required ImageSource imageSource, required String type}) async {
    try {
      var permissionStatus = await requestImagePermission(imageSource);
      if (!permissionStatus.isGranted) {
        return null;
      }

      if (permissionStatus.isGranted) {
        final pickedFile = await ImagePicker().pickImage(source: imageSource);
        print("File is picked");

        if (pickedFile != null) {
          //Cropping the image
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: pickedFile.path,
            compressQuality: 100,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            maxWidth: 512,
            maxHeight: 512,
          );

          try {
            toggleImageLoading(type, true);

            //Select Image
            var file = File(croppedFile!.path);

            if (file != null) {
              //Upload to Firebase

              var response =
                  await _generatorsRepository.uploadImage(file, type);
              toggleImageLoading(type, false);

              if (response.isOk) {
                setImageUrl(
                    type,
                    UploadImageResponse.fromJson(response.body)
                        .data!
                        .imageUrl!);

                Get.snackbar('Success', 'Image uploaded successfully',
                    backgroundColor: Colors.green,
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
              }
            } else {
              Get.snackbar('Failed', 'Image not selected',
                  margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
            }
          } catch (e) {
            logItem("---------------Image upload error-----------------");
            logItem(e.toString());
            Get.snackbar('Failed', 'Error uploading file',
                margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
          }
        }
      } else {
        Get.snackbar('Failed', 'Permission not granted',
            margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } catch (e) {
      toggleImageLoading(type, false);
      // emit(UploadImageFailed(e.toString()));
    }
  }

  toggleImageLoading(String type, bool value) {
    if (type == "gen_before") {
      genLevelBeforeImageLoading.value = value;
    } else if (type == "gen_after") {
      genLevelAfterImageLoading.value = value;
    } else if (type == "invoice") {
      invoiceImageLoading.value = value;
    } else if (type == "waybill") {
      wayBillImageLoading.value = value;
    }
  }

  setImageUrl(String type, String url) {
    logItem(url);
    if (type == "gen_before") {
      genLevelBeforeImage.value = url;
    } else if (type == "gen_after") {
      genLevelAfterImage.value = url;
    } else if (type == "invoice") {
      invoiceImage.value = url;
    } else if (type == "waybill") {
      wayBillImage.value = url;
    }
  }
}
