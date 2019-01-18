import 'package:flutter_account/chilli_account.dart';
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

  test('can register the user', () {
    final userService = MockUserService();
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();

    when(userService.register(any)).thenAnswer(
        (_) => Future.value(ServiceResult.success(createFakeUserData())));

    when(sessionService.saveSession(any)).thenAnswer((_) => Future.value());

    final bloc = UserBloc(
      userService: userService,
      sessionService: sessionService,
      sessionTracker: sessionTracker,
    );

    bloc.registerCommand.execute(RegistrationInfo(
      acceptTermsConditions: true,
      deviceId: "12335",
      email: "max@bluechilli.com",
      firstName: "Max",
      lastName: "Onishi",
      password: "123455",
      isAnonymous: false,
    ));

    expectLater(
      bloc.registerCommand,
      emits(Session.fromUserData(createFakeUserData())),
    );
  });

  test('should add session when registeration successful', () {
    final userService = MockUserService();
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();

    when(userService.register(any)).thenAnswer(
        (_) => Future.value(ServiceResult.success(createFakeUserData())));

    when(sessionService.saveSession(any)).thenAnswer((_) => Future.value());

    final bloc = UserBloc(
      userService: userService,
      sessionService: sessionService,
      sessionTracker: sessionTracker,
    );

    bloc.registerCommand.execute(RegistrationInfo(
      acceptTermsConditions: true,
      deviceId: "12335",
      email: "max@bluechilli.com",
      firstName: "Max",
      lastName: "Onishi",
      password: "123455",
      isAnonymous: false,
    ));

    expectLater(
      sessionTracker.session,
      emits(Session.fromUserData(createFakeUserData())),
    );
  });

  test('failed registration should throw exception', () {
    final userService = MockUserService();
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();

    when(userService.register(any))
        .thenAnswer((_) => Future.value(ServiceResult.failure()));

    when(sessionService.saveSession(any)).thenAnswer((_) => Future.value());

    final bloc = UserBloc(
      userService: userService,
      sessionService: sessionService,
      sessionTracker: sessionTracker,
    );

    bloc.registerCommand.execute(RegistrationInfo(
      acceptTermsConditions: true,
      deviceId: "12335",
      email: "max@bluechilli.com",
      firstName: "Max",
      lastName: "Onishi",
      password: "123455",
      isAnonymous: false,
    ));

    expectLater(
      bloc.registerCommand.thrownExceptions,
      emits(isException),
    );
  });
}
