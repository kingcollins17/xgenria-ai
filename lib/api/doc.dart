import 'package:dio/dio.dart';
import '../models/access_token.dart';
import '../models/doc.dart';
import '_config.dart' as cfg;

abstract class DocumentAPI {
  static Future<DocumentResponse> documents(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/documents').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        data: response.statusCode == 200
            ? DocumentData.fromJson(response.data)
            : null,
        message: response.statusCode == 200
            ? 'Documents fetched'
            : response.data['message'] as String,
        status: response.statusCode == 200
      );
    } catch (e) {
      return (data: null, message: e.toString(), status: false);
    }
  }

  static Future<dynamic> createDoc(
    Dio dio,
    AccessToken token, {
    required String name,
    int type = 38,
    required String text,
  }) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/document/create').toString(),
        data: {'name': name, 'type': type, 'text': text},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } on Exception catch (e) {
      return e;
    }
  }

  static Future<dynamic> readDoc(Dio dio, AccessToken token) async {}
}

typedef DocumentResponse = ({DocumentData? data, String message, bool status});
