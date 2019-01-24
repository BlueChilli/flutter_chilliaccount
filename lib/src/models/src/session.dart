import 'package:chilli_account/chilli_account.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String userKey;
  final UserData userData;

  Session({
    @required this.userKey,
    @required this.userData,
  }) : super([userKey]);

  Session copyWith(UserData userData) {
    return Session(userKey: userKey, userData: userData);
  }

  static const fromJson = _$SessionFromJson;

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  factory Session.fromUserData(UserData userData) {
    return Session(userKey: userData.userKey, userData: userData);
  }
}

Session _$SessionFromJson(Map<String, dynamic> json) {
  var data = UserData.fromJson(json);
  return Session(userData: data, userKey: data.userKey);
}

Map<String, dynamic> _$SessionToJson(Session instance) {
  return instance.userData.toJson();
}
