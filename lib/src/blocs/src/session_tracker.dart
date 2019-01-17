import 'package:flutter_account/chilli_account.dart';
import 'package:rxdart/rxdart.dart';

class SessionTracker {
  final BehaviorSubject<Session> _sessionController =
      BehaviorSubject<Session>();
  ValueObservable<Session> get session => _sessionController.stream;
  void sessionLoaded(Session session) => _sessionController.add(session);
  void sessionEnded() => _sessionController.add(null);

  void dispose() {
    _sessionController.close();
  }
}
