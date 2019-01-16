import "dart:async";
import "package:chopper/chopper.dart";
import 'package:flutter_account/models/model.dart';

part "definition.chopper.dart";

@ChopperApi(baseUrl: "/api/v1")
abstract class AccountApi extends ChopperService {
  static AccountApi create([ChopperClient client]) => _$AccountApi(client);

  @Post(url: "/devices/push/tokens")
  Future<Response> registerPushToken(@Body() Map<String, dynamic> tokenInfo);

  @Post(url: "/users/byemail")
  Future<Response<UserData>> registerUser(
      @Body() Map<String, dynamic> registrationInfo);

  @Post(url: "/usersessions/byemail")
  Future<Response<UserData>> login(@Body() Map<String, dynamic> loginInfo);

  @Patch(url: "/users/current")
  Future<Response<UserData>> updateUserInfo(
      @Body() Map<String, dynamic> userInfo);

  @Put(url: "/users/current")
  Future<Response<UserData>> changeUserInfo(
      @Body() Map<String, dynamic> userInfo);
}
