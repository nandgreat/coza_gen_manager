import 'package:coza_gen_manager/models/signup/SignupRequest.dart';
import 'package:coza_gen_manager/utils/endpoints.dart';
import 'package:coza_gen_manager/utils/helpers.dart';
import 'package:get/get.dart';

import '../../models/login/login_request.dart';
import '../api/api_client.dart';

class AuthRepository extends GetxService {
  ApiClient apiClient = ApiClient(appbaseurl: Endpoints.BASE_URL);

  Future<Response> login(LoginRequest body) async {
    String url = Endpoints.LOGIN;

    logItem("HHHHHHHHHHHHHHHHH");
    return apiClient.postRequest(url: url, data: body.toJson());
  }
  Future<Response> signup(SignupRequest body) async {
    String url = Endpoints.REGISTER;
    return apiClient.postRequest(url: url, data: body.toJson());
  }
  Future<Response> verifyOtp(String otp) async {
    String url = Endpoints.VERIFY_OTP;
    return apiClient.get("$url$otp");
  }
}
