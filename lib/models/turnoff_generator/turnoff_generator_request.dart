import 'dart:convert';
TurnoffGeneratorRequest turnoffGeneratorRequestFromJson(String str) => TurnoffGeneratorRequest.fromJson(json.decode(str));
String turnoffGeneratorRequestToJson(TurnoffGeneratorRequest data) => json.encode(data.toJson());
class TurnoffGeneratorRequest {
  TurnoffGeneratorRequest({
      num? generatorId, 
      String? workerCode, 
      num? dieselLevel,}){
    _generatorId = generatorId;
    _workerCode = workerCode;
    _dieselLevel = dieselLevel;
}

  TurnoffGeneratorRequest.fromJson(dynamic json) {
    _generatorId = json['generator_id'];
    _workerCode = json['worker_code'];
    _dieselLevel = json['diesel_level'];
  }
  num? _generatorId;
  String? _workerCode;
  num? _dieselLevel;
TurnoffGeneratorRequest copyWith({  num? generatorId,
  String? workerCode,
  num? dieselLevel,
}) => TurnoffGeneratorRequest(  generatorId: generatorId ?? _generatorId,
  workerCode: workerCode ?? _workerCode,
  dieselLevel: dieselLevel ?? _dieselLevel,
);
  num? get generatorId => _generatorId;
  String? get workerCode => _workerCode;
  num? get dieselLevel => _dieselLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['generator_id'] = _generatorId;
    map['worker_code'] = _workerCode;
    map['diesel_level'] = _dieselLevel;
    return map;
  }

}