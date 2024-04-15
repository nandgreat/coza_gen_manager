import 'dart:convert';
ApprovalAdminResponse approvalAdminResponseFromJson(String str) => ApprovalAdminResponse.fromJson(json.decode(str));
String approvalAdminResponseToJson(ApprovalAdminResponse data) => json.encode(data.toJson());
class ApprovalAdminResponse {
  ApprovalAdminResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ApprovalAdminResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Data>? _data;
ApprovalAdminResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => ApprovalAdminResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? approvalAdmin, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _approvalAdmin = approvalAdmin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _approvalAdmin = json['approval_admin'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _approvalAdmin;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  String? approvalAdmin,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  approvalAdmin: approvalAdmin ?? _approvalAdmin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get approvalAdmin => _approvalAdmin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['approval_admin'] = _approvalAdmin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}