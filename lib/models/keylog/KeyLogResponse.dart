class KeyLogResponse {
  KeyLogResponse({
      bool? success,
      String? message,}){
    _success = success;
    _message = message;
}

  KeyLogResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }
  bool? _success;
  String? _message;
KeyLogResponse copyWith({  bool? success,
  String? message,
}) => KeyLogResponse(  success: success ?? _success,
  message: message ?? _message,
);
  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }
}