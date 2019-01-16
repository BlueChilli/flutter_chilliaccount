// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$AccountApi extends AccountApi with ChopperServiceMixin {
  _$AccountApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = AccountApi;

  Future<Response> registerPushToken(Map<String, dynamic> tokenInfo) {
    final url = '/api/v1/devices/push/tokens';
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
}
