import 'package:chilli_account/chilli_account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserService extends Mock implements UserService {}

class MockSessionService extends Mock implements SessionService {}

void main() {
  UserData createFakeUserData() {
    return UserData(
      email: "max@bluechilli.com",
      userKey: "1235",
      fullName: "Max Onishi",
    );
  }

  test('should be able to login with username and password', () {
    final userService = MockUserService();
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();

    when(userService.login(any)).thenAnswer(
        (_) => Future.value(ServiceResult.success(createFakeUserData())));

    when(sessionService.saveSession(any)).thenAnswer((_) => Future.value());

    final bloc = AuthenticationBloc(
        sessionService: sessionService,
        sessionTracker: sessionTracker,
        userService: userService);

    bloc.loginCommand.execute(LoginRequest(
      email: "max@bluechilli.com",
      password: "123456",
    ));

    expectLater(
      bloc.loginCommand,
      emits(Session.fromUserData(createFakeUserData())),
    );
  });

  test('should be able to logout', () {
    final sessionService = MockSessionService();
    final userService = MockUserService();
    final sessionTracker = SessionTracker();

    when(userService.logout()).thenAnswer(
        (_) async => await Future.value(ServiceResult.successWithNoData()));

    when(sessionService.removeSession()).thenAnswer((_) => Future.value());

    final bloc = AuthenticationBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.logoutCommand.execute();

    expect(
      bloc.logoutCommand,
      emits(true),
    );
  });

  test('session is available when login successfully', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    when(userService.login(any)).thenAnswer(
        (_) => Future.value(ServiceResult.success(createFakeUserData())));

    final bloc = AuthenticationBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.loginCommand.execute(LoginRequest(
      email: "max@bluechilli.com",
      password: "123456",
    ));

    expect(
      sessionTracker.session,
      emits(Session.fromUserData(createFakeUserData())),
    );
  });

  test('session gets clear when logout successfully', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    when(userService.logout()).thenAnswer(
        (_) async => await Future.value(ServiceResult.successWithNoData()));

    when(sessionService.saveSession(any)).thenAnswer((_) => Future.value());

    final bloc = AuthenticationBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.logoutCommand.execute();

    expect(
      sessionTracker.session,
      emits(null),
    );
  });

  test('failed login should throw exception', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    when(userService.login(any))
        .thenAnswer((_) => Future.value(ServiceResult.failure()));

    final bloc = AuthenticationBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.loginCommand.execute(LoginRequest(
      email: "max@bluechilli.com",
      password: "123456",
    ));

    expect(
      bloc.loginCommand.thrownExceptions,
      emits(isException),
    );
  });

  test('failed logout should still expire the session', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    when(userService.login(any)).thenAnswer((_) async =>
        await Future.value(ServiceResult.success(createFakeUserData())));

    when(userService.logout())
        .thenAnswer((_) => Future.value(ServiceResult.failure()));

    when(sessionService.removeSession()).thenAnswer((_) => Future.value());

    final bloc = AuthenticationBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.logoutCommand.execute();

    expect(sessionTracker.session, emits(null));
  });

  test('can load session if available', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    when(userService.login(any)).thenAnswer((_) async =>
        await Future.value(ServiceResult.success(createFakeUserData())));

    when(userService.logout())
        .thenAnswer((_) => Future.value(ServiceResult.failure()));

    when(sessionService.loadSession()).thenAnswer((_) => Future.value(
        ServiceResult.success(Session.fromUserData(createFakeUserData()))));

    when(userService.refreshUserSession())
        .thenAnswer((_) => Future.value(ServiceResult.failure()));

    final bloc = AuthenticationBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.loadSessionCommand.execute();

    expect(sessionTracker.session,
        emits(Session.fromUserData(createFakeUserData())));
  });
}
