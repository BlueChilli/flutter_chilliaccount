import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
    this.deviceId,
  });

  final String email;
  final String password;
  final String deviceId;

  static const fromJson = _$LoginRequestFromJson;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegistrationInfo {
  RegistrationInfo(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.deviceId,
      this.acceptTermsConditions = true,
      this.isAnonymous = true,
      this.anonymousUserId});

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String deviceId;
  final bool acceptTermsConditions;
  final bool isAnonymous;
  final String anonymousUserId;

  static const fromJson = _$RegistrationInfoFromJson;

  Map<String, dynamic> toJson() => _$RegistrationInfoToJson(this);
}

enum UserStatus { Registered, Activated, Deleted, Invited, Anonymous }

@JsonSerializable()
class UserData {
  UserData({
    this.userKey,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.statusRaw,
    this.roles = const [],
    this.profilePhoto,
    this.anonymous = false,
  });

  String userKey;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  @JsonKey(name: "status")
  final String statusRaw;
  final List<String> roles;
  @JsonKey(name: 'profilePhotoPath')
  final String profilePhoto;
  final bool anonymous;

  static const fromJson = _$UserDataFromJson;

  factory UserData.copyWith({
    String userKey,
    @required UserData userData,
  }) {
    return UserData(
      userKey: userData.userKey ?? userKey,
      firstName: userData.firstName,
      lastName: userData.lastName,
      fullName: userData.fullName,
      email: userData.email,
      statusRaw: userData.statusRaw,
      roles: userData.roles,
      profilePhoto: userData.profilePhoto,
      anonymous: userData.anonymous,
    );
  }

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserStatus get status {
    return statusRaw != null
        ? UserStatus.values.firstWhere(
            (d) => describeEnum(d).toLowerCase() == statusRaw.toLowerCase())
        : UserStatus.Registered;
  }

  bool isAnonymous() => status == UserStatus.Anonymous;
}

@JsonSerializable()
class UserInfoUpdateRequest {
  UserInfoUpdateRequest({
    this.currentPassword,
    this.email,
    this.emailSpecified = false,
    this.password,
    this.passwordSpecified = false,
    this.firstname,
    this.lastname,
    this.status,
    this.nameSpecified = false,
  });

  final String currentPassword;
  final String email;
  final bool emailSpecified;
  final String password;
  final bool passwordSpecified;
  final String status;
  final String firstname;
  final String lastname;
  final bool nameSpecified;

  static const fromJson = _$UserInfoUpdateRequestFromJson;

  Map<String, dynamic> toJson() => _$UserInfoUpdateRequestToJson(this);
}

@JsonSerializable()
class PushTokenInfo {
  PushTokenInfo({
    this.deviceId,
    this.token,
  });

  final String deviceId;
  final String token;

  static const fromJson = _$PushTokenInfoFromJson;

  Map<String, dynamic> toJson() => _$PushTokenInfoToJson(this);
}

@JsonSerializable()
class ResetPasswordTokenRequest {
  ResetPasswordTokenRequest({
    this.email,
    this.type = "Password",
  });

  final String email;
  final String type;

  static const fromJson = _$ResetPasswordTokenRequestFromJson;

  Map<String, dynamic> toJson() => _$ResetPasswordTokenRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordRequest {
  ResetPasswordRequest({
    this.email,
    this.firstname,
    this.lastname,
    this.password,
    this.token,
  });

  final String firstname;
  final String lastname;
  final String password;
  final String email;
  final String token;

  static const fromJson = _$ResetPasswordRequestFromJson;

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
