import 'dart:convert';

import 'package:chilli_account/chilli_account.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chopper/chopper.dart';

const kSession = "Session";

abstract class SessionService {
  Future<ServiceResult<Session>> loadSession();
  Future<void> saveSession(Session session);
  Future<void> removeSession();
}

class SessionServiceImpl with ServiceMixin implements SessionService {
  final Future<SharedPreferences> preference;
  final Logger logger;

  SessionServiceImpl({
    @required this.preference,
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
