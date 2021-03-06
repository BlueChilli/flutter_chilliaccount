import 'package:chilli_account/chilli_account.dart';
import 'package:meta/meta.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc {
  final SessionService sessionService;
  final SessionTracker sessionTracker;
  final UserService userService;
  RxCommand<LoginRequest, Session> _loginCommand;
  RxCommand<void, bool> _logoutCommand;
  RxCommand<void, Session> _loadSessionCommand;

  AuthenticationBloc({
    @required this.sessionTracker,
    @required this.sessionService,
    @required this.userService,
  })  : assert(sessionTracker != null),
        assert(sessionService != null) {
    _loginCommand = RxCommand.createAsync<LoginRequest, Session>((req) async {
      var r = await userService.login(req);

      if (r.isSuccessful) {
        var session = Session.fromUserData(r.result);
        await sessionService.saveSession(session);
        sessionTracker.sessionLoaded(session);
        return session;
      }

      throw r.getException();
    });

    _logoutCommand = RxCommand.createAsyncNoParam<bool>(() async {
      await userService.logout();
      await sessionService.removeSession();
      sessionTracker.sessionEnded();
      return true;
    });

    _loadSessionCommand = RxCommand.createAsyncNoParam<Session>(() async {
      var r = await sessionService.loadSession();

      if (r.isSuccessful) {
        var session = r.result;
        var r1 = await userService.refreshUserSession();

        if (r1.isSuccessful) {
          session = session.copyWith(r1.result);
        }

        sessionTracker.sessionLoaded(session);

        return r.result;
      }

      throw r.getException();
    });
  }

  RxCommand<LoginRequest, Session> get loginCommand => _loginCommand;

  RxCommand<void, bool> get logoutCommand => _logoutCommand;

  RxCommand<void, Session> get loadSessionCommand => _loadSessionCommand;
}
