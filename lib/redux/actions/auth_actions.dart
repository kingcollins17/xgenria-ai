import 'package:dio/dio.dart';

import 'base.dart';

///Actions that can be called on a store
base class AuthAction extends XgenriaAction {
  final AuthActionType type;

  AuthAction({required this.type, super.payload});
}

///The different types of actions
enum AuthActionType {
  ///Requires RegistrationPayload
  register,

  ///requires [LoginPayload]
  login,
  logout,

  ///requires [NotifyPayload]
  notify,

  ///Clears the notification
  clear,

  ///requires ({String message, AccessToken? token})
  updateLogin,
}

class RegistrationPayload extends Payload {
  final Dio client;
  final String name;
  final String email;
  final String password;
  final String confirmedPassword;

  RegistrationPayload(
      {required this.client,
      super.onDone,
      super.onError,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmedPassword});
}

///LoginPayload

class LoginPayload extends Payload {
  final String email, password;
  final bool rememberMe;
  final Dio client;

  LoginPayload({
    super.onDone,
    super.onError,
    required this.client,
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}
