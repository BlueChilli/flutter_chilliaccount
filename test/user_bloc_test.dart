import 'package:chopper/chopper.dart';
import 'package:flutter_account/chilli_account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
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

  test('should update the name and password when passwordSpcified is true', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    final userDataWithNameChanged = UserData(
      email: "max@bluechilli.com",
      userKey: "12345",
      fullName: "Max Onishi",
    );
    final userDataWithPasswordChanged = UserData(
      email: "max@bluechilli.com",
      userKey: "12345",
      fullName: "Max Onishi",
    );

    when(userService.patchUserInfo(any)).thenAnswer(
        (_) => Future.value(ServiceResult.success(userDataWithNameChanged)));

    when(userService.updateUserInfo(any)).thenAnswer((_) =>
        Future.value(ServiceResult.success(userDataWithPasswordChanged)));

    final bloc = UserBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.updateUserCommand.execute(UserInfoUpdateRequest(
      currentPassword: '12345',
      email: 'max@bluechilli.com',
      emailSpecified: false,
      firstname: 'test',
      lastname: 'test2',
      nameSpecified: true,
      passwordSpecified: true,
      password: '1234',
    ));

    expect(
      bloc.updateUserCommand,
      emits(Session.fromUserData(userDataWithPasswordChanged)),
    );

    verify(userService.patchUserInfo(any));
  });

  test('should update the name when nameSpecified is true', () {
    final sessionService = MockSessionService();
    final sessionTracker = SessionTracker();
    final userService = MockUserService();

    final userDataWithNameChanged = UserData(
      email: "max@bluechilli.com",
      userKey: "12345",
      fullName: "Max Onishi",
    );
    final userDataWithPasswordChanged = UserData(
      email: "max@bluechilli.com",
      userKey: "12345",
      fullName: "Max Onishi",
    );

    when(userService.patchUserInfo(any)).thenAnswer(
        (_) => Future.value(ServiceResult.success(userDataWithNameChanged)));

    when(userService.updateUserInfo(any)).thenAnswer((_) =>
        Future.value(ServiceResult.success(userDataWithPasswordChanged)));

    final bloc = UserBloc(
      sessionService: sessionService,
      sessionTracker: sessionTracker,
      userService: userService,
    );

    bloc.updateUserCommand.execute(UserInfoUpdateRequest(
      currentPassword: '12345',
      email: 'max@bluechilli.com',
      emailSpecified: false,
      firstname: 'test',
      lastname: 'test2',
      nameSpecified: true,
      passwordSpecified: false,
      password: '1234',
    ));

    expect(
      bloc.updateUserCommand,
      emits(Session.fromUserData(userDataWithPasswordChanged)),
    );

    verify(userService.updateUserInfo(any));
    verifyNever(userService.patchUserInfo(any));
  });
}
