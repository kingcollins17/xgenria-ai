import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xgenria/api/auth.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/models/user_data.dart';
import 'package:xgenria/providers/providers.dart';

part 'auth_provider.g.dart';

class AuthState {
  final AccessToken? token;
  final UserData? userData;

  bool get isAuthenticated => token != null;
  AuthState({this.token, this.userData});
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => AuthState();

  Future<dynamic> login(
      {required String email,
      required String password,
      bool rememberMe = true}) async {
    final dio = ref.read(dioProvider);
    final response = await AuthAPI.login(
      dio,
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    state = AuthState(token: response.token);
    ref.notifyListeners();
    return response.message;
  }
}
