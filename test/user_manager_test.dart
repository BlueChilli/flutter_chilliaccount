import 'package:flutter_account/managers/user_manager.dart';
import 'package:flutter_account/models/model.dart';
import 'package:flutter_account/models/service_result.dart';
import 'package:flutter_account/models/session.dart';
import 'package:flutter_account/services/session_service.dart';
import 'package:flutter_account/services/user_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockUserService extends Mock implements UserService {}

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  Session createFakeSession() {
    return Session(
        userKey: "1",
        userData: UserData(
          email: "max@bluechilli.com",
          userKey: "1235",
          fullName: "Max Onishi",
        ));
  }

  test('should be able to login with username and password', () {
    final userService = MockUserService();
    final sessionService = SessionServiceImpl(
        preference: Future.value(
      MockSharedPreference(),
    ));

    final session = createFakeSession();

    when(userService.login(any)).thenAnswer(
        (_) async => await Future.value(ServiceResult.success(session)));

    final userManager = UserManagerImpl(
      userService: userService,
      sessionService: sessionService,
    );

    userManager.loginCommand.execute(LoginRequest(
      email: "max@bluechilli.com",
      password: "123456",
    ));

    expect(
      userManager.loginCommand,
      emits(session),
    );
  });

  test('should be able to logout', () {
    final userService = MockUserService();
    final sessionService = SessionServiceImpl(
        preference: Future.value(
      MockSharedPreference(),
    ));

    when(userService.logout()).thenAnswer(
        (_) async => await Future.value(ServiceResult.successWithNoData()));

    final userManager = UserManagerImpl(
      userService: userService,
      sessionService: sessionService,
    );

    userManager.logoutCommand.execute();

    expect(
      userManager.logoutCommand,
      emits(true),
    );
  });
}
