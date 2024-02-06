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
}

typedef DocumentResponse = ({DocumentData? data, String message, bool status});
