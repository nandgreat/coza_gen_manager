import 'dart:convert';
RefuelGeneratorResponse refuelGeneratorResponseFromJson(String str) => RefuelGeneratorResponse.fromJson(json.decode(str));
String refuelGeneratorResponseToJson(RefuelGeneratorResponse data) => json.encode(data.toJson());
class RefuelGeneratorResponse {
  RefuelGeneratorResponse({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RefuelGeneratorResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
RefuelGeneratorResponse copyWith({  String? status,
  String? message,
  Data? data,
}) => RefuelGeneratorResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      DieselDetails? dieselDetails,}){
    _dieselDetails = dieselDetails;
}

  Data.fromJson(dynamic json) {
    _dieselDetails = json['diesel_details'] != null ? DieselDetails.fromJson(json['diesel_details']) : null;
  }
  DieselDetails? _dieselDetails;
Data copyWith({  DieselDetails? dieselDetails,
}) => Data(  dieselDetails: dieselDetails ?? _dieselDetails,
);
  DieselDetails? get dieselDetails => _dieselDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dieselDetails != null) {
      map['diesel_details'] = _dieselDetails?.toJson();
    }
    return map;
  }

}

DieselDetails dieselDetailsFromJson(String str) => DieselDetails.fromJson(json.decode(str));
String dieselDetailsToJson(DieselDetails data) => json.encode(data.toJson());
class DieselDetails {
  DieselDetails({
      num? id, 
      num? dieselLevel, 
      num? updatedBy, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _dieselLevel = dieselLevel;
    _updatedBy = updatedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  DieselDetails.fromJson(dynamic json) {
    _id = json['id'];
    _dieselLevel = json['diesel_level'];
    _updatedBy = json['updated_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _dieselLevel;
  num? _updatedBy;
  String? _createdAt;
  String? _updatedAt;
DieselDetails copyWith({  num? id,
  num? dieselLevel,
  num? updatedBy,
  String? createdAt,
  String? updatedAt,
}) => DieselDetails(  id: id ?? _id,
  dieselLevel: dieselLevel ?? _dieselLevel,
  updatedBy: updatedBy ?? _updatedBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get dieselLevel => _dieselLevel;
  num? get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['diesel_level'] = _dieselLevel;
    map['updated_by'] = _updatedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}