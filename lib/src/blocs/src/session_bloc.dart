import 'package:flutter_account/chilli_account.dart';
import 'package:meta/meta.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class SessionBloc {
  final SessionService sessionService;
  final SessionTracker sessionTracker;
  AuthValidator _validator;
  RxCommand<LoginRequest, Session> _loginCommand;
  RxCommand<void, bool> _logoutCommand;
  RxCommand<void, Session> _loadSessionCommand;
  final _emailController = BehaviorSubject<String>(seedValue: null);
  final _passwordController = BehaviorSubject<String>(seedValue: null);

  SessionBloc({
    @required this.sessionTracker,
    @required this.sessionService,
    AuthValidator validator,
  })  : assert(sessionTracker != null),
        assert(sessionService != null) {
    _validator = validator ?? AuthValidatorImpl();

    _loginCommand = RxCommand.createAsync<LoginRequest, Session>((req) async {
      var r = await sessionService.login(req);

      if (r.isSuccessful) {
        var session = Session.fromUserData(r.result);
        await sessionService.saveSession(session);
        sessionTracker.sessionLoaded(session);
        return session;
      }

      throw r.getException();
    });

    _logoutCommand = RxCommand.createAsyncNoParam<bool>(() async {
      await sessionService.logout();
      await sessionService.removeSession();
      sessionTracker.sessionEnded();
      return true;
    });

    _loadSessionCommand = RxCommand.createAsyncNoParam<Session>(() async {
      var r = await sessionService.loadSession();

      if (r.isSuccessful) {
        var session = r.result;
        var r1 = await sessionService.currentUser();

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

  Observable<String> get email =>
      _emailController.stream.transform(_validator.validateEmail);
  Observable<String> get password =>
      _passwordController.stream.transform(_validator.validatePassword);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}