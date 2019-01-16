// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceId: json['deviceId'] as String);
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'deviceId': instance.deviceId
    };

RegistrationInfo _$RegistrationInfoFromJson(Map<String, dynamic> json) {
  return RegistrationInfo(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      deviceId: json['deviceId'] as String,
      acceptTermsConditions: json['acceptTermsConditions'] as bool,
      isAnonymous: json['isAnonymous'] as bool,
      anonymousUserId: json['anonymousUserId'] as String);
}

Map<String, dynamic> _$RegistrationInfoToJson(RegistrationInfo instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'deviceId': instance.deviceId,
      'acceptTermsConditions': instance.acceptTermsConditions,
      'isAnonymous': instance.isAnonymous,
      'anonymousUserId': instance.anonymousUserId
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
      userKey: json['userKey'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      statusRaw: json['status'] as String,
      roles: (json['roles'] as List)?.map((e) => e as String)?.toList(),
      profilePhoto: json['profilePhotoPath'] as String,
      anonymous: json['anonymous'] as bool);
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userKey': instance.userKey,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'email': instance.email,
      'status': instance.statusRaw,
      'roles': instance.roles,
      'profilePhotoPath': instance.profilePhoto,
      'anonymous': instance.anonymous
    };
