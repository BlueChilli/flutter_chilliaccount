// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$UsersApi extends UsersApi with ChopperServiceMixin {
  _$UsersApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = UsersApi;

  Future<Response> registerPushToken(Map<String, dynamic> tokenInfo) {
    final url = '/api/v1/mobiledevicepushtokens';
    final body = tokenInfo;
    final request = new Request('POST', url, body: body);
    return client.send(request);
  }

  Future<Response<UserData>> registerUser(
      Map<String, dynamic> registrationInfo) {
    final url = '/api/v1/users/byemail';
    final body = registrationInfo;
    final request = new Request('POST', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response<UserData>> login(Map<String, dynamic> loginInfo) {
    final url = '/api/v1/usersessions/byemail';
    final body = loginInfo;
    final request = new Request('POST', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response<UserData>> loginByMobileNumber(
      Map<String, dynamic> loginInfo) {
    final url = '/api/v1/usersessions/byphone';
    final body = loginInfo;
    final request = new Request('POST', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response<UserData>> loginByPin(Map<String, dynamic> loginInfo) {
    final url = '/api/v1/usersessions/byphone';
    final body = loginInfo;
    final request = new Request('POST', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response<UserData>> requestVerificationCode(Map<String, dynamic> req) {
    final url = '/api/v1/usersessions/byphone/coderequest';
    final body = req;
    final request = new Request('POST', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response> logout() {
    final url = '/api/v1/usersessions/current';
    final request = new Request('DELETE', url);
    return client.send(request);
  }

  Future<Response<UserData>> currentSession() {
    final url = '/api/v1/usersessions/current';
    final request = new Request('GET', url);
    return client.send<UserData>(request);
  }

  Future<Response<UserData>> updateUserInfo(Map<String, dynamic> userInfo) {
    final url = '/api/v1/users/current';
    final body = userInfo;
    final request = new Request('PATCH', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response<UserData>> changeUserInfo(Map<String, dynamic> userInfo) {
    final url = '/api/v1/users/current';
    final body = userInfo;
    final request = new Request('PUT', url, body: body);
    return client.send<UserData>(request);
  }

  Future<Response> requestResetPasswordToken(Map<String, dynamic> tokenInfo) {
    final url = '/api/v1/users/tokens';
    final body = tokenInfo;
    final request = new Request('POST', url, body: body);
    return client.send(request);
  }

  Future<Response> resetPassword(
      String tokenId, Map<String, dynamic> tokenInfo) {
    final url = '/api/v1/users/bytoken/$tokenId';
    final body = tokenInfo;
    final request = new Request('PATCH', url, body: body);
    return client.send(request);
  }
}
