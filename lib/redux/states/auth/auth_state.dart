import '../../../models/access_token.dart';
import '../../notification/state_notification.dart';

class AuthState {
  AccessToken? accessToken;
  bool isLoading = false;

  StateNotification? notification;
  bool get isAuthenticated => accessToken != null;

  AuthState({this.accessToken, this.isLoading = false});

  AuthState.init();
}
