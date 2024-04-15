import 'dart:convert';
LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
LoginResponse copyWith({  String? status,
  String? message,
  Data? data,
}) => LoginResponse(  status: status ?? _status,
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
      Auth? auth, 
      User? user, 
      DieselDetails? dieselDetails,}){
    _auth = auth;
    _user = user;
    _dieselDetails = dieselDetails;
}

  Data.fromJson(dynamic json) {
    _auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _dieselDetails = json['diesel_details'] != null ? DieselDetails.fromJson(json['diesel_details']) : null;
  }
  Auth? _auth;
  User? _user;
  DieselDetails? _dieselDetails;
Data copyWith({  Auth? auth,
  User? user,
  DieselDetails? dieselDetails,
}) => Data(  auth: auth ?? _auth,
  user: user ?? _user,
  dieselDetails: dieselDetails ?? _dieselDetails,
);
  Auth? get auth => _auth;
  User? get user => _user;
  DieselDetails? get dieselDetails => _dieselDetails;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_auth != null) {
      map['auth'] = _auth?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
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
      num? dieselLevel,}){
    _dieselLevel = dieselLevel;
}


  set dieselLevel(num? value) {
    _dieselLevel = value;
  }

  DieselDetails.fromJson(dynamic json) {
    _dieselLevel = json['diesel_level'];
  }
  num? _dieselLevel;
DieselDetails copyWith({  num? dieselLevel,
}) => DieselDetails(  dieselLevel: dieselLevel ?? _dieselLevel,
);
  num? get dieselLevel => _dieselLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diesel_level'] = _dieselLevel;
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      dynamic emailVerifiedAt, 
      String? workerCode, 
      num? departmentId, 
      dynamic imageUrl, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _workerCode = workerCode;
    _departmentId = departmentId;
    _imageUrl = imageUrl;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _workerCode = json['worker_code'];
    _departmentId = json['department_id'];
    _imageUrl = json['image_url'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _emailVerifiedAt;
  String? _workerCode;
  num? _departmentId;
  dynamic _imageUrl;
  String? _createdAt;
  String? _updatedAt;
User copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? email,
  dynamic emailVerifiedAt,
  String? workerCode,
  num? departmentId,
  dynamic imageUrl,
  String? createdAt,
  String? updatedAt,
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  workerCode: workerCode ?? _workerCode,
  departmentId: departmentId ?? _departmentId,
  imageUrl: imageUrl ?? _imageUrl,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get workerCode => _workerCode;
  num? get departmentId => _departmentId;
  dynamic get imageUrl => _imageUrl;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['worker_code'] = _workerCode;
    map['department_id'] = _departmentId;
    map['image_url'] = _imageUrl;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));
String authToJson(Auth data) => json.encode(data.toJson());
class Auth {
  Auth({
      String? accessToken,}){
    _accessToken = accessToken;
}

  Auth.fromJson(dynamic json) {
    _accessToken = json['access_token'];
  }
  String? _accessToken;
Auth copyWith({  String? accessToken,
}) => Auth(  accessToken: accessToken ?? _accessToken,
);
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    return map;
  }

}