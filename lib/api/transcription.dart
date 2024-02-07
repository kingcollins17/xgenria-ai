import 'package:dio/dio.dart';
import '../models/access_token.dart';

import '_config.dart' as cfg;

abstract class TranscriptionAPI {
  static Future<dynamic> transcriptions(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/transcriptions').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
