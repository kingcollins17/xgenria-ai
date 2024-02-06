import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';

import '_config.dart' as cfg;

abstract class ChatAPI {
  static Future<dynamic> chats(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, 'chats').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
