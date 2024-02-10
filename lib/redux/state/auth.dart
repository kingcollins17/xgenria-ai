import '../../models/access_token.dart';
import '../../models/user_data.dart';

///
class AuthState {
  AccessToken? token;
  UserData? userData;

  bool get isAuthenticated => token != null;
}
