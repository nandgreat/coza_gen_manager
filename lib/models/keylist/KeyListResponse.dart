/// success : true
/// message : "Key Added successfully."
/// data : [{"id":1,"key_name":"CCU Key","key_status":"0","created_at":"2023-05-26T09:40:33.000000Z","updated_at":"2023-05-26T09:40:33.000000Z"},{"id":2,"key_name":"Child Care Key","key_status":"0","created_at":"2023-05-26T09:40:33.000000Z","updated_at":"2023-05-26T09:40:33.000000Z"}]

class KeyListResponse {
  KeyListResponse({
      bool? success, 
      String? message, 
      List<Keys>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  KeyListResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Keys.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Keys>? _data;
KeyListResponse copyWith({  bool? success,
  String? message,
  List<Keys>? data,
}) => KeyListResponse(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  String? get message => _message;
  List<Keys>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// key_name : "CCU Key"
/// key_status : "0"
/// created_at : "2023-05-26T09:40:33.000000Z"
/// updated_at : "2023-05-26T09:40:33.000000Z"

class Keys {
  Keys({
      int? id,
      String? keyName, 
      String? keyStatus, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _keyName = keyName;
    _keyStatus = keyStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Keys.fromJson(dynamic json) {
    _id = json['id'];
    _keyName = json['key_name'];
    _keyStatus = json['key_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _keyName;
  String? _keyStatus;
  String? _createdAt;
  String? _updatedAt;
Keys copyWith({  int? id,
  String? keyName,
  String? keyStatus,
  String? createdAt,
  String? updatedAt,
}) => Keys(  id: id ?? _id,
  keyName: keyName ?? _keyName,
  keyStatus: keyStatus ?? _keyStatus,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  String? get keyName => _keyName;
  String? get keyStatus => _keyStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['key_name'] = _keyName;
    map['key_status'] = _keyStatus;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}