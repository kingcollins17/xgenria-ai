import 'package:dio/dio.dart';

import 'base.dart';

///Actions that can be called on a store
base class AuthAction extends XgenriaAction {
  final AuthActionType type;

  AuthAction({required this.type, super.payload});
}

///The different types of actions
enum AuthActionType {
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


