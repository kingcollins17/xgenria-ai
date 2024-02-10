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

  static Future<dynamic> createImage(
    Dio dio,
    AccessToken token, {
    String name = '',
    required String input,
    String style = '3D Render',
    String size = '1024x1024',
  }) async {
    try {
      final response = await dio.post(
          Uri.https(cfg.domain, '/image/create').toString(),
          data: {},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      return e;
    }
  }
}
