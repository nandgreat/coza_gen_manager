class Endpoints {
  static const String APP_NAME = "COZA App";
  static const int APP_VERSION = 1;

  // static const String BASE_URL = "http://10.0.2.2:8000/api/v1/";

  static const String BASE_URL =
      "https://cozaoperations.nandomkumchi.com/api/v1/";

  static const String REGISTER = "register";
  static const String LOGIN = "login";
  static const String generators = "generators";
  static const String generatorPurposes = "generators/purposes";
  static const String approvalAdmins = "approval-admins";
  static const String dieselBalance = "diesel/check";
  static const String turnOnGen = "generator-usage/turn-on";
  static const String turnOffGen = "generator-usage/turn-off";
  static const String refuelGen = "diesel/refuel";
  static const String DROP_KEY = "key-logs/drop";
  static const String VERIFY_OTP = "auth/verify/";

  static String UPLOAD_IMAGE = "upload-image";
}
