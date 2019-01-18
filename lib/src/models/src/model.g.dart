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

UserInfoUpdateRequest _$UserInfoUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return UserInfoUpdateRequest(
      currentPassword: json['currentPassword'] as String,
      email: json['email'] as String,
      emailSpecified: json['emailSpecified'] as bool,
      password: json['password'] as String,
      passwordSpecified: json['passwordSpecified'] as bool,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      status: json['status'] as String,
      nameSpecified: json['nameSpecified'] as bool);
}

Map<String, dynamic> _$UserInfoUpdateRequestToJson(
        UserInfoUpdateRequest instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'email': instance.email,
      'emailSpecified': instance.emailSpecified,
      'password': instance.password,
      'passwordSpecified': instance.passwordSpecified,
      'status': instance.status,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'nameSpecified': instance.nameSpecified
    };

PushTokenInfo _$PushTokenInfoFromJson(Map<String, dynamic> json) {
  return PushTokenInfo(
      deviceId: json['deviceId'] as String, token: json['token'] as String);
}

Map<String, dynamic> _$PushTokenInfoToJson(PushTokenInfo instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'token': instance.token};

ResetPasswordTokenRequest _$ResetPasswordTokenRequestFromJson(
    Map<String, dynamic> json) {
  return ResetPasswordTokenRequest(
      email: json['email'] as String, type: json['type'] as String);
}

Map<String, dynamic> _$ResetPasswordTokenRequestToJson(
        ResetPasswordTokenRequest instance) =>
    <String, dynamic>{'email': instance.email, 'type': instance.type};

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return ResetPasswordRequest(
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      password: json['password'] as String,
      token: json['token'] as String);
}

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'password': instance.password,
      'email': instance.email,
      'token': instance.token
    };
