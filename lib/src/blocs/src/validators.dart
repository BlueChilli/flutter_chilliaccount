import 'dart:async';

import 'package:chilli_account/chilli_account.dart';

abstract class AuthValidator {
  StreamTransformer<String, String> get validateEmail;
  StreamTransformer<String, String> get validatePassword;
}

class AuthValidatorImpl implements AuthValidator {
  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email == null) {
      sink.addError("Email field is required.");
    } else if (!EmailValidator.validate(email)) {
      sink.addError("Please enter correct email address");
    } else {
      sink.add(email);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password == null || password.isEmpty || password.trim().isEmpty) {
      sink.addError("Password field is required.");
    } else {
      sink.add(password);
    }
  });

  @override
  StreamTransformer<String, String> get validatePassword => _validatePassword;

  @override
  StreamTransformer<String, String> get validateEmail => _validateEmail;
}
