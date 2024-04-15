import 'dart:convert';
TurnOnGenRequest turnOnGenRequestFromJson(String str) => TurnOnGenRequest.fromJson(json.decode(str));
String turnOnGenRequestToJson(TurnOnGenRequest data) => json.encode(data.toJson());
class TurnOnGenRequest {
  TurnOnGenRequest({
      List<num>? generators, 
      String? workerCode, 
      num? generatorPurposeId, 
      String? generatorLoad, 
      num? approvedBy,}){
    _generators = generators;
    _workerCode = workerCode;
    _generatorPurposeId = generatorPurposeId;
    _generatorLoad = generatorLoad;
    _approvedBy = approvedBy;
}

  TurnOnGenRequest.fromJson(dynamic json) {
    _generators = json['generators'] != null ? json['generators'].cast<num>() : [];
    _workerCode = json['worker_code'];
    _generatorPurposeId = json['generator_purpose_id'];
    _generatorLoad = json['generator_load'];
    _approvedBy = json['approved_by'];
  }
  List<num>? _generators;
  String? _workerCode;
  num? _generatorPurposeId;
  String? _generatorLoad;
  num? _approvedBy;
TurnOnGenRequest copyWith({  List<num>? generators,
  String? workerCode,
  num? generatorPurposeId,
  String? generatorLoad,
  num? approvedBy,
}) => TurnOnGenRequest(  generators: generators ?? _generators,
  workerCode: workerCode ?? _workerCode,
  generatorPurposeId: generatorPurposeId ?? _generatorPurposeId,
  generatorLoad: generatorLoad ?? _generatorLoad,
  approvedBy: approvedBy ?? _approvedBy,
);
  List<num>? get generators => _generators;
  String? get workerCode => _workerCode;
  num? get generatorPurposeId => _generatorPurposeId;
  String? get generatorLoad => _generatorLoad;
  num? get approvedBy => _approvedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['generators'] = _generators;
    map['worker_code'] = _workerCode;
    map['generator_purpose_id'] = _generatorPurposeId;
    map['generator_load'] = _generatorLoad;
    map['approved_by'] = _approvedBy;
    return map;
  }

}