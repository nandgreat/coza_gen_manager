import 'dart:convert';
GeneratorPurposeResponse generatorPurposeResponseFromJson(String str) => GeneratorPurposeResponse.fromJson(json.decode(str));
String generatorPurposeResponseToJson(GeneratorPurposeResponse data) => json.encode(data.toJson());
class GeneratorPurposeResponse {
  GeneratorPurposeResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GeneratorPurposeResponse.fromJson(dynamic json) {
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
GeneratorPurposeResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => GeneratorPurposeResponse(  status: status ?? _status,
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
      String? generatorPurpose, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _generatorPurpose = generatorPurpose;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _generatorPurpose = json['generator_purpose'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _generatorPurpose;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  String? generatorPurpose,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  generatorPurpose: generatorPurpose ?? _generatorPurpose,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get generatorPurpose => _generatorPurpose;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['generator_purpose'] = _generatorPurpose;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}