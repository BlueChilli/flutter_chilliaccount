import 'package:flutter_account/chilli_account.dart';
import 'package:meta/meta.dart';
import 'package:rx_command/rx_command.dart';

class UserBloc {
  final UserService userService;
  final SessionService sessionService;
  final SessionTracker sessionTracker;
  RxCommand<RegistrationInfo, Session> _registerCommand;
  RxCommand<PushTokenInfo, void> _registerPushTokenCommand;
  RxCommand<UserInfoUpdateRequest, Session> _updateUserCommand;
  RxCommand<ResetPasswordTokenRequest, void> _requestPasswordResetCommand;
  RxCommand<ResetPasswordRequest, Session> _resetPasswordCommand;

  UserBloc({
    @required this.userService,
    @required this.sessionService,
    @required this.sessionTracker,
  })  : assert(sessionTracker != null),
        assert(userService != null) {
    _registerCommand =
        RxCommand.createAsync<RegistrationInfo, Session>((info) async {
      var r = await userService.register(info);

      if (r.isSuccessful) {
        var session = Session.fromUserData(r.result);
        await sessionService.saveSession(session);
        sessionTracker.sessionLoaded(session);
        return session;
      }

      throw r.getException();
    });

    _registerPushTokenCommand =
        RxCommand.createAsyncNoResult<PushTokenInfo>((info) async {
      var r = await userService.registerPushToken(info);

      if (!r.isSuccessful) {
        throw r.getException();
      }
    });

    _updateUserCommand =
        RxCommand.createAsync<UserInfoUpdateRequest, Session>((info) async {
      ServiceResult<UserData> r;

      if (info.passwordSpecified) {
        r = await userService.patchUserInfo(info);
      }

      if (info.nameSpecified) {
        r = await userService.updateUserInfo(info);
      }

      if (r.isSuccessful) {
        var userData = UserData.copyWith(
          userKey: sessionTracker.session?.value?.userKey,
          userData: r.result,
        );
        var session = Session.fromUserData(userData);
        await sessionService.saveSession(session);
        sessionTracker.sessionLoaded(session);
        return session;
      }

      throw r.getException();
    });

    _requestPasswordResetCommand =
        RxCommand.createAsyncNoResult<ResetPasswordTokenRequest>((info) async {
      var r = await userService.requestResetPasswordToken(info);

      if (!r.isSuccessful) {
        throw r.getException();
      }
    });

    _resetPasswordCommand =
        RxCommand.createAsync<ResetPasswordRequest, Session>((info) async {
      var r = await userService.resetPassword(info);

      if (r.isSuccessful) {
        var userData = UserData.copyWith(
          userKey: sessionTracker.session?.value?.userKey,
          userData: r.result,
        );
        var session = Session.fromUserData(userData);
        await sessionService.saveSession(session);
        sessionTracker.sessionLoaded(session);
        return session;
      }

      throw r.getException();
    });
  }

  RxCommand<RegistrationInfo, Session> get registerCommand => _registerCommand;
  RxCommand<PushTokenInfo, void> get registerPushTokenCommand =>
      _registerPushTokenCommand;
  RxCommand<UserInfoUpdateRequest, Session> get updateUserCommand =>
      _updateUserCommand;
  RxCommand<ResetPasswordTokenRequest, void> get requestPasswordResetCommand =>
      _requestPasswordResetCommand;
  RxCommand<ResetPasswordRequest, Session> get resetPasswordCommand =>
      _resetPasswordCommand;
}
