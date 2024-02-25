import 'package:dio/dio.dart';
import 'package:xgenria/models/models.dart';
import '_config.dart' as cfg;

typedef RegisterResponse = ({String message, bool status});

abstract class AuthAPI {
  static Future<({List<PlanData>? data, String message, bool status})> plan(
    Dio dio,
    AccessToken token,
  ) async {
    try {
      final response = await dio.get(Uri.https(cfg.domain, '/plans').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return (
        status: response.statusCode == 200,
        data: response.statusCode == 200
            ? (response.data['data'] as List<dynamic>)
                .map((e) => PlanData.fromJson(e))
                .toList()
            : null,
        message: 'Fetched'
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage, data: null);
    } catch (e) {
      return (status: false, message: e.runtimeType.toString(), data: null);
    }
  }

  static Future<({UserData? data, String message, bool status})> user(
      Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(Uri.https(cfg.domain, '/user').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        data: response.statusCode == 200
            ? UserData.fromJson(response.data)
            : null,
        message: response.statusCode == 200
            ? 'Fetched'
            : response.data['message'].toString()
      );
    } on DioException catch (_) {
      return (status: false, data: null, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, data: null, message: e.runtimeType.toString());
    }
  }

  static Future<RegisterResponse> register(
    Dio dio, {
    required String name,
    required String email,
    required String password,
    required String confirmedPassword,
  }) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/auth/register').toString(),
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmedPassword,
        },
      );
      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString()
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }

  ///
  static Future<({bool status, String message})> forgotPassword(
      Dio dio,
      //  AccessToken token,
      {email = 'kingcollins172@gmail.com'}) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/auth/forgot-password/$email').toString(),
        // options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString()
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }

  ///returns null for token and an error message if login is unsuccessful
  static Future<({AccessToken? token, String message})> login(
    Dio dio, {
    String email = 'ajayimarvellous777@gmail.com',
    // String email = 'kingcollins172@gmail.com',
    String password = 'password',
    // String password = 'kingpass',
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
    } on DioException catch (_) {
      return (token: null, message: cfg.connectErrorMessage);
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
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }

  static Future<dynamic> confirmPasswordToken(Dio dio, AccessToken token,
      {required String passwordToken}) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/confirm-password-token/$passwordToken')
              .toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> resetPassword(
    Dio dio,
    AccessToken token, {
    required String passwordToken,
    required String newPassword,
    required String confirmation,
  }) async {
    try {
      final response = await dio.post(Uri.https(cfg.domain).toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (e) {
      return e;
    }
  }

  ///Delete account
  static Future<({String message, bool status})> deleteAccount(
      Dio dio, AccessToken token, String password) async {
    try {
      final response = await dio.delete(
          Uri.https(cfg.domain, '/delete-account').toString(),
          data: {'password': password},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString()
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, message: e.runtimeType.toString());
    }
  }
}

typedef MessageResponse = ({bool status, String message});
