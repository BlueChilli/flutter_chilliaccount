import "dart:async";
import "package:chopper/chopper.dart";
import 'package:flutter_account/chilli_account.dart';

part "definition.chopper.dart";

@ChopperApi(baseUrl: "/api/v1")
abstract class UsersApi extends ChopperService {
  static UsersApi create([ChopperClient client]) => _$UsersApi(client);

  @Post(url: "/mobiledevicepushtokens")
  Future<Response> registerPushToken(@Body() Map<String, dynamic> tokenInfo);

  @Post(url: "/users/byemail")
  Future<Response<UserData>> registerUser(
      @Body() Map<String, dynamic> registrationInfo);

  @Post(url: "/usersessions/byemail")
  Future<Response<UserData>> login(@Body() Map<String, dynamic> loginInfo);

  @Post(url: "/usersessions/byphone")
  Future<Response<UserData>> loginByMobileNumber(
      @Body() Map<String, dynamic> loginInfo);

  @Post(url: "/usersessions/byphone")
  Future<Response<UserData>> loginByPin(@Body() Map<String, dynamic> loginInfo);

  @Post(url: "/usersessions/byphone/coderequest")
  Future<Response<UserData>> requestVerificationCode(
      @Body() Map<String, dynamic> req);

  @Delete(url: "/usersessions/current")
  Future<Response> logout();

  @Get(url: "/usersessions/current")
  Future<Response<UserData>> currentSession();

  @Patch(url: "/users/current")
  Future<Response<UserData>> updateUserInfo(
      @Body() Map<String, dynamic> userInfo);

  @Put(url: "/users/current")
  Future<Response<UserData>> changeUserInfo(
      @Body() Map<String, dynamic> userInfo);

  @Post(url: "/users/tokens")
  Future<Response> requestResetPasswordToken(
      @Body() Map<String, dynamic> tokenInfo);

  @Patch(url: "/users/bytoken/{tokenId}")
  Future<Response> resetPassword(
      @Path("tokenId") String tokenId, @Body() Map<String, dynamic> tokenInfo);
}
