import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

showSnackBar({required title, required message, required type}) {
  var color = type == "error"
      ? Colors.red
      : (type == "success" ? Colors.green : Colors.blue);
  Get.snackbar(title, message, backgroundColor: color, colorText: Colors.white);
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
}

String formatMoney(num input) {
  return NumberFormat.decimalPattern().format(input);
}

logItem(item) {
  if (kDebugMode) {
    print(item);
  }
}


Future<PermissionStatus> requestImagePermission(ImageSource imageSource) async {
  logItem("hhhhhhhhhh");

  if (imageSource == ImageSource.gallery) {
    if (Platform.isIOS) {
      return await Permission.photos.request();
    } else {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;

      logItem(release);

      if (int.parse(release) <= 12) {
        return await Permission.storage.request();
      } else {
        return await Permission.photos.request();
      }
    }
  } else {
    return await Permission.camera.request();
  }
}

showNoInternetSnackBar() {
  showSnackBar(
      title: "Network Error", message: "No Internet Connection", type: 'error');
}
