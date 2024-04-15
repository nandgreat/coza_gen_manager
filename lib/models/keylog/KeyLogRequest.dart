class KeyLogRequest {
  KeyLogRequest({
      this.workerCode, 
      this.keyId,});

  KeyLogRequest.fromJson(dynamic json) {
    workerCode = json['worker_code'];
    keyId = json['key_id'];
  }
  String? workerCode;
  int? keyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['worker_code'] = workerCode;
    map['key_id'] = keyId;
    return map;
  }

}