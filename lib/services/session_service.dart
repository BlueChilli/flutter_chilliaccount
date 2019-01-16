import 'package:flutter_account/models/session.dart';
import 'package:flutter_account/services/service_base.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionService {
  void startSession(Session session);
  void endSession();
  ValueObservable<Session> get session;
}

class SessionServiceImpl with ServiceBase implements SessionService {
  final Future<SharedPreferences> preference;
  final BehaviorSubject<Session> _session = BehaviorSubject(seedValue: null);

  SessionServiceImpl({
    @required this.preference,
  });

  void dispose() {
    _session?.close();
  }

  @override
  void endSession() {
    _session?.add(null);
  }

  @override
  ValueObservable<Session> get session => _session.stream;

  @override
  void startSession(Session session) {
    _session?.add(session);
  }
}
