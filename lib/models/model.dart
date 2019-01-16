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

  final String userKey;
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

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserStatus get status {
    return statusRaw != null
        ? UserStatus.values.firstWhere(
            (d) => describeEnum(d).toLowerCase() == statusRaw.toLowerCase())
        : UserStatus.Registered;
  }

  bool isAnonymous() => status == UserStatus.Anonymous;
}
