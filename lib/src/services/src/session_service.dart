import 'dart:convert';

import 'package:flutter_account/chilli_account.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chopper/chopper.dart';

const kSession = "Session";

abstract class SessionService {
  Future<ServiceResult<Session>> loadSession();
  Future<void> saveSession(Session session);
  Future<void> removeSession();
  Future<ServiceResult<UserData>> login(LoginRequest req);
  Future<ServiceResult> logout();
  Future<ServiceResult<UserData>> currentUser();
}

class SessionServiceImpl with ServiceMixin implements SessionService {
  final Future<SharedPreferences> preference;
  final UsersApi api;
  final Logger logger;

  SessionServiceImpl({
    @required this.preference,
    @required this.api,
    this.logger,
  });

  @override
  Future<ServiceResult<Session>> loadSession() async {
    try {
      var prefs = await preference;
      var sessionString = prefs.getString(kSession);
      if (sessionString != null && sessionString.isNotEmpty) {
        return ServiceResult.success(
            Session.fromJson(json.decode(sessionString)));
      }
      return ServiceResult.success(null);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<Session>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult<UserData>> currentUser() async {
    try {
      var response = await api.currentUser();
      return ServiceResult.success(response.body);
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult<UserData>> login(LoginRequest req) async {
    try {
      var response = await api.login(req.toJson());
      return ServiceResult.success(response.body);
    } on Response catch (error) {
      return getErrorInfo<UserData>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo<UserData>(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult> logout() async {
    try {
      await api.logout();
      return ServiceResult.successWithNoData();
    } on Response catch (error) {
      return getErrorInfo(error, logger);
    } on Exception catch (error, stacktrace) {
      return logErrorInfo(
          this.runtimeType.toString(), error, stacktrace, logger);
    }
  }

  @override
  Future<void> removeSession() async {
    var prefs = await preference;
    await prefs.remove(kSession);
  }

  @override
  Future<void> saveSession(Session session) async {
    var prefs = await preference;
    if (session != null) {
      await prefs.setString(kSession, json.encode(session.toJson()));
    }
  }
}
