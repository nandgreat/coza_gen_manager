import 'dart:convert';
import 'dart:math';

import 'package:coza_gen_manager/utils/endpoints.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:get/get.dart';

import '../../modules/login/login_screen.dart';
import '../../utils/local_storage_helper.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token = Endpoints.BASE_URL;
  late String appbaseurl;
  late Map<String, String> _mainHeader;
  LocalStorageHelper localStorageHelper = LocalStorageHelper();

  ApiClient({required String appbaseurl}) {
    baseUrl = appbaseurl;

    timeout = const Duration(seconds: 30);
    _mainHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    };
  }

// POST METHOD
  Future<Response> getRequest({
    required String url,
  }) async {
    try {
      Response response;

      LocalStorageHelper localStorageHelper = LocalStorageHelper();

      String? dataString = await localStorageHelper.retrieveItem(key: "user");

      String token = jsonDecode(dataString!)['auth']['access_token'];

      _mainHeader = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": "Bearer ${token}",
      };

      logItem("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      logItem(token);
      // The below request is the same as above.
      response = await get(url, headers: _mainHeader);
      print(response.body.toString());
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }


// POST METHOD
  Future<Response> postRequest(
      {required String url, required Map<dynamic, dynamic> data}) async {
    try {
      Response response;
      // The below request is the same as above.
      print("--------------------------------------");
      print(data);
      LocalStorageHelper localStorageHelper = LocalStorageHelper();

      String? dataString = await localStorageHelper.retrieveItem(key: "user");
      print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");

      if (dataString != null) {
        token = jsonDecode(dataString!)['auth']['access_token'];
      }

      _mainHeader = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      };
      response = await post(url, data, headers: _mainHeader);
      print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
      print(response.body.toString());
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

// POST METHOD
  Future<Response> postUploadRequest(
      {required String url, required List<int> image, required String type}) async {
    try {
      var rng = Random();
      var newRand = rng.nextInt(100);
      final form = FormData({
        'image': MultipartFile(image, filename: 'avatar$newRand.png'),
        'image_type': type
      });


      var token = await localStorageHelper.retrieveItem(key: "token");

      _mainHeader = {
        "Authorization": "Bearer ${token}",
      };

      Response response;
      // The below request is the same as above.
      response = await post(url, form, headers: _mainHeader);

      if (response.body == null) {
        showSnackBar(title: "Error",
            message: "Kindly check your internet connection",
            type: "error");
      }

      if (response.status.code == 401) {
        Get.offAll(const LoginScreen());
      }
      print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");

      print(response.status.code);
      print(response.body.toString());
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}