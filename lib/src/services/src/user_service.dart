import 'dart:async';

import 'package:flutter_account/chilli_account.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:chopper/chopper.dart';

abstract class UserService {
  Future<ServiceResult<UserData>> register(RegistrationInfo info);
  Future<ServiceResult<UserData>> patchUserInfo(UserInfoUpdateRequest req);
  Future<ServiceResult<UserData>> updateUserInfo(UserInfoUpdateRequest req);
  Future<ServiceResult> registerPushToken(PushTokenInfo info);
  Future<ServiceResult> requestResetPasswordToken(
      ResetPasswordTokenRequest req);
  Future<ServiceResult<UserData>> resetPassword(ResetPasswordRequest req);
}

class UserServiceImpl with ServiceMixin implements UserService {
  final UsersApi api;
  final Logger logger;

  UserServiceImpl({
    @required this.api,
    this.logger,
  });

  @override
  Future<ServiceResult<UserData>> register(RegistrationInfo info) async {
    try {
      var response = await api.registerUser(info.toJson());
      return ServiceResult.success(response.body);
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult<UserData>> patchUserInfo(
      UserInfoUpdateRequest req) async {
    try {
      var response = await api.changeUserInfo(req.toJson());
      return ServiceResult.success(response.body);
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult> registerPushToken(PushTokenInfo info) async {
    try {
      await api.registerPushToken(info.toJson());
      return ServiceResult.successWithNoData();
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult> requestResetPasswordToken(
      ResetPasswordTokenRequest req) async {
    try {
      await api.requestResetPasswordToken(req.toJson());
      return ServiceResult.successWithNoData();
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult<UserData>> resetPassword(
      ResetPasswordRequest req) async {
    try {
      var response = await api.resetPassword(req.token, req.toJson());
      return ServiceResult.success(response.body);
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult<UserData>> updateUserInfo(
      UserInfoUpdateRequest req) async {
    try {
      var response = await api.updateUserInfo(req.toJson());
      return ServiceResult.success(response.body);
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }
}
