import 'dart:io';

import 'package:coza_gen_manager/models/keylog/KeyLogRequest.dart';
import 'package:coza_gen_manager/models/refuel_generator/Refuel_generator_request.dart';
import 'package:coza_gen_manager/models/signup/SignupRequest.dart';
import 'package:coza_gen_manager/models/turnoff_generator/turnoff_generator_request.dart';
import 'package:coza_gen_manager/models/turnon_generator/turn_on_gen_request.dart';
import 'package:coza_gen_manager/utils/endpoints.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class GeneratorsRepository extends GetxService {
  ApiClient apiClient = ApiClient(appbaseurl: Endpoints.BASE_URL);

  Future<Response> getGenerators() async {
    String url = Endpoints.generators;
    logItem(url);
    return apiClient.getRequest(url: url);
  }

  Future<Response> getGeneratorPurposes() async {
    String url = Endpoints.generatorPurposes;
    logItem(url);
    return apiClient.getRequest(url: url);
  }

  Future<Response> getAdmins() async {
    String url = Endpoints.approvalAdmins;
    logItem(url);
    return apiClient.getRequest(url: url);
  }
  Future<Response> getDieselLevel() async {
    String url = Endpoints.dieselBalance;
    logItem(url);
    return apiClient.getRequest(url: url);
  }


  Future<Response> uploadImage(dynamic data, String type) async {
    String url = Endpoints.UPLOAD_IMAGE;

    var convertedFiled = fileToBytes(data);
    return apiClient.postUploadRequest(url: url, image: convertedFiled, type: type);
  }

  Future<Response> turnOnGen(TurnOnGenRequest body) async {
    String url = Endpoints.turnOnGen;
    return apiClient.postRequest(url: url, data: body.toJson());
  }

  Future<Response> refuelGen(RefuelGeneratorRequest body) async {
    String url = Endpoints.refuelGen;
    return apiClient.postRequest(url: url, data: body.toJson());
  }

  Future<Response> turnOffGen(TurnoffGeneratorRequest body) async {
    String url = Endpoints.turnOffGen;
    return apiClient.postRequest(url: url, data: body.toJson());
  }
  Future<Response> dropKey(KeyLogRequest body) async {
    String url = Endpoints.DROP_KEY;
    return apiClient.postRequest(url: url, data: body.toJson());
  }

  Future<Response> verifyOtp(String otp) async {
    String url = Endpoints.VERIFY_OTP;
    return apiClient.get("$url$otp");
  }


  List<int> fileToBytes(dynamic data) {
    if (data is File) {
      return data.readAsBytesSync();
    } else if (data is String) {
      if (File(data).existsSync()) {
        return File(data).readAsBytesSync();
      } else {
        throw 'File $data not exists';
      }
    } else if (data is List<int>) {
      return data;
    } else {
      throw const FormatException(
          'File is not "File" or "String" or "List<int>"');
    }
  }
}
