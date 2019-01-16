import 'package:flutter_account/models/model.dart';
import 'package:flutter_account/models/session.dart';
import 'package:flutter_account/services/session_service.dart';
import 'package:flutter_account/services/user_service.dart';
import 'package:meta/meta.dart';
import 'package:rx_command/rx_command.dart';

abstract class UserManager {
  RxCommand<LoginRequest, void> get loginCommand;
  RxCommand<void, bool> get logoutCommand;
}

class UserManagerImpl implements UserManager {
  final UserService userService;
  final SessionService sessionService;
  RxCommand<LoginRequest, Session> _loginCommand;
  RxCommand<void, bool> _logoutCommand;

  UserManagerImpl({
    @required this.userService,
    @required this.sessionService,
  }) {
    _loginCommand = RxCommand.createAsync<LoginRequest, Session>((req) async {
      var r = await userService.login(req);

      if (r.isSuccessful) {
        sessionService.startSession(r.result);
        return r.result;
      }

      throw r.getException();
    });

    _logoutCommand = RxCommand.createAsyncNoParam<bool>(() async {
      var r = await userService.logout();

      if (r.isSuccessful) {
        sessionService.endSession();
        return true;
      }

      throw r.getException();
    });
  }

  @override
  // TODO: implement loginCommand
  RxCommand<LoginRequest, Session> get loginCommand => _loginCommand;

  @override
  // TODO: implement logoutCommand
  RxCommand<void, bool> get logoutCommand => _logoutCommand;
}
