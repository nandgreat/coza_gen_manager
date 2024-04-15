import 'dart:convert';
TurnOnGenResponse turnOnGenResponseFromJson(String str) => TurnOnGenResponse.fromJson(json.decode(str));
String turnOnGenResponseToJson(TurnOnGenResponse data) => json.encode(data.toJson());
class TurnOnGenResponse {
  TurnOnGenResponse({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TurnOnGenResponse.fromJson(dynamic json) {
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
TurnOnGenResponse copyWith({  String? status,
  String? message,
  List<Data>? data,
}) => TurnOnGenResponse(  status: status ?? _status,
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
      num? generatorId, 
      String? timeOn, 
      num? usageSessionId, 
      num? turnOnWorkerId, 
      num? generatorPurposeId, 
      String? generatorLoad, 
      num? approvedBy, 
      String? updatedAt, 
      String? createdAt, 
      num? id,}){
    _generatorId = generatorId;
    _timeOn = timeOn;
    _usageSessionId = usageSessionId;
    _turnOnWorkerId = turnOnWorkerId;
    _generatorPurposeId = generatorPurposeId;
    _generatorLoad = generatorLoad;
    _approvedBy = approvedBy;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _generatorId = json['generator_id'];
    _timeOn = json['time_on'];
    _usageSessionId = json['usage_session_id'];
    _turnOnWorkerId = json['turn_on_worker_id'];
    _generatorPurposeId = json['generator_purpose_id'];
    _generatorLoad = json['generator_load'];
    _approvedBy = json['approved_by'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  num? _generatorId;
  String? _timeOn;
  num? _usageSessionId;
  num? _turnOnWorkerId;
  num? _generatorPurposeId;
  String? _generatorLoad;
  num? _approvedBy;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
Data copyWith({  num? generatorId,
  String? timeOn,
  num? usageSessionId,
  num? turnOnWorkerId,
  num? generatorPurposeId,
  String? generatorLoad,
  num? approvedBy,
  String? updatedAt,
  String? createdAt,
  num? id,
}) => Data(  generatorId: generatorId ?? _generatorId,
  timeOn: timeOn ?? _timeOn,
  usageSessionId: usageSessionId ?? _usageSessionId,
  turnOnWorkerId: turnOnWorkerId ?? _turnOnWorkerId,
  generatorPurposeId: generatorPurposeId ?? _generatorPurposeId,
  generatorLoad: generatorLoad ?? _generatorLoad,
  approvedBy: approvedBy ?? _approvedBy,
  updatedAt: updatedAt ?? _updatedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
);
  num? get generatorId => _generatorId;
  String? get timeOn => _timeOn;
  num? get usageSessionId => _usageSessionId;
  num? get turnOnWorkerId => _turnOnWorkerId;
  num? get generatorPurposeId => _generatorPurposeId;
  String? get generatorLoad => _generatorLoad;
  num? get approvedBy => _approvedBy;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['generator_id'] = _generatorId;
    map['time_on'] = _timeOn;
    map['usage_session_id'] = _usageSessionId;
    map['turn_on_worker_id'] = _turnOnWorkerId;
    map['generator_purpose_id'] = _generatorPurposeId;
    map['generator_load'] = _generatorLoad;
    map['approved_by'] = _approvedBy;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}