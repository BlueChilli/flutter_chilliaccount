import 'dart:async';

import 'package:flutter_account/models/model.dart';
import 'package:flutter_account/models/service_result.dart';
import 'package:flutter_account/models/session.dart';
import 'package:flutter_account/services/api/api.dart';
import 'package:flutter_account/services/service_base.dart';
import 'package:meta/meta.dart';
import 'package:chopper/chopper.dart';
import 'package:logging/logging.dart';

abstract class UserService {
  Future<ServiceResult<Session>> login(LoginRequest req);
  Future<ServiceResult> logout();
}

class UserServiceImpl with ServiceBase implements UserService {
  final AccountApi api;
  final Logger logger;

  UserServiceImpl({
    @required this.api,
    this.logger,
  });

  @override
  Future<ServiceResult<Session>> login(LoginRequest req) async {
    assert(login != null);
    try {
      var response = await api.login(req.toJson());
      return ServiceResult.success(Session(
        userKey: response.body.userKey,
        userData: response.body,
      ));
    } on Response catch (error) {
      return getErrorInfo<Session>(error, logger);
    } on Exception catch (error, stacktrace) {
      return logAndGetErrorInfo<Session>(
          "UserService", error, stacktrace, logger);
    }
  }

  @override
  Future<ServiceResult> logout() async {
    // TODO: implement logout
    return ServiceResult.successWithNoData();
  }
}
