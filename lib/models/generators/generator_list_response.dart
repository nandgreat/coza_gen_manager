import 'dart:convert';
GeneratorListResponse generatorListResponseFromJson(String str) => GeneratorListResponse.fromJson(json.decode(str));
String generatorListResponseToJson(GeneratorListResponse data) => json.encode(data.toJson());
class GeneratorListResponse {
  GeneratorListResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GeneratorListResponse.fromJson(dynamic json) {
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
GeneratorListResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GeneratorListResponse(  status: status ?? _status,
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
      String? generatorName, 
      num? statusId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _generatorName = generatorName;
    _statusId = statusId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _generatorName = json['generator_name'];
    _statusId = json['status_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _generatorName;
  num? _statusId;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  String? generatorName,
  num? statusId,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  generatorName: generatorName ?? _generatorName,
  statusId: statusId ?? _statusId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get generatorName => _generatorName;
  num? get statusId => _statusId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['generator_name'] = _generatorName;
    map['status_id'] = _statusId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}