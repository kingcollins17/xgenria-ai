import 'package:xgenria/redux/actions/base.dart';

enum AuthActionType {
  ///login action requires LoginPayload as payload
  login,
  register,

  ///rewuires XgenriaNetworkPayload
  logout,

  ///requires ({AccessToken? token, StateNotification notification})
  updateLogin,
  updateLogout,
  notify,
  clear,
}

base class AuthStateAction extends XgenriaStateAction {
  final AuthActionType type;
  AuthStateAction({required this.type, required super.payload});
}
