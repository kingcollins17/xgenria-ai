import 'package:dio/dio.dart';
import '../models/access_token.dart';

import '_config.dart' as cfg;

abstract class ImageAPI {
  static Future<dynamic> images(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/images').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      return e;
    }
  }
}
