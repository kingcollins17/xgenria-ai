import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/redux/notification/state_notification.dart';

//
class LoginPayload {
  final Dio client;
  final String email;
  final String password;
  final bool rememberMe;

  final void Function(dynamic)? onError;
  final void Function()? onDone;

  LoginPayload({
    required this.client,
    required this.email,
    required this.password,
    this.rememberMe = false,
    this.onError,
    this.onDone,
  });
}

//
typedef UpdateLoginPayload = ({
  AccessToken? token,
  StateNotification notification
});

//
class UpdateLogoutPayload {
  final bool status;
  final StateNotification notification;

  UpdateLogoutPayload({required this.status, required this.notification});
}
