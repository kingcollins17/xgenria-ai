import 'base.dart';

///Actions that can be called on a store
base class AuthAction extends XgenriaAction {
  final AuthActionType type;

  AuthAction({required this.type, super.payload});
}

///The different types of actions
enum AuthActionType { register, login, logout, notify, update }

///LoginPayload
class LoginPayload extends Payload {
  final String email, password;
  final bool rememberMe;

  LoginPayload({
    super.onDone,
    super.onError,
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class NotifyPayload extends Payload {
  final String notification;

  NotifyPayload({super.onDone, super.onError, required this.notification});
}
