import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/models/user_data.dart';
import '_config.dart' as cfg;

abstract class AuthAPI {
  static Future<dynamic> user(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(Uri.https(cfg.domain, '/user').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return UserData.fromJson(response.data);
    } on TypeError catch (err) {
      return (err.toString(), err.stackTrace);
    } catch (e) {
      return e;
    }
  }

  ///
  static Future<({bool status, String message})> forgotPassword(
      Dio dio, AccessToken token,
      {email = 'kingcollins172@gmail.com'}) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/auth/forgot-password/$email').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString()
      );
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }

  ///returns null for token and an error message if login is unsuccessful
  static Future<({AccessToken? token, String message})> login(
    Dio dio, {
    // String email = 'ajayimarvellous777@gmail.com',
    String email = 'kingcollins172@gmail.com',
    // String password = 'password',
    String password = 'kingpass',
    bool rememberMe = true,
  }) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/auth/login').toString(),
        data: {'email': email, 'password': password, 'remember': rememberMe},
      );

      return response.statusCode == 401
          ? (token: null, message: response.data['message'] as String)
          : response.statusCode == 200
              ? (
                  token: AccessToken.fromJson(response.data),
                  message: "You are Signed in"
                )
              : (token: null, message: 'Unable to Sign you in');
    } catch (e) {
      return (token: null, message: e.toString());
    }
  }

  ///returns a map with key "message"
  static Future<MessageResponse> logout(Dio dio, AccessToken token) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/auth/logout').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        message: response.data['message'] as String
      );
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }

  static Future<MessageResponse> changePassword(
    Dio dio,
    AccessToken token, {
    String currentPassword = 'newPassword',
    String newPassword = 'password',
    String confirmPassword = 'password',
  }) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/auth/change-password').toString(),
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        message: response.data['message'] as String
      );
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }
}

typedef MessageResponse = ({bool status, String message});
