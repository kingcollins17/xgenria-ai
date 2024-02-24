import 'package:dio/dio.dart';
import '../models/access_token.dart';
import '../models/doc.dart';
import '_config.dart' as cfg;

typedef CreateDocResponse = ({int? id, String message, bool status});

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
    } on TypeError catch (e) {
      return (data: null, message: e.stackTrace.toString(), status: false);
    }
  }

  static Future<CreateDocResponse> createDoc(
    Dio dio,
    AccessToken token, {
    required String name,
    int type = 38,
    int? projectId,
    required String text,
  }) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/document/create').toString(),
        data: {
          'name': name,
          'type': type,
          'text': text,
          if (projectId != null) 'project_id': projectId
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        id: response.statusCode == 200
            ? int.parse(response.data['data']['id'].toString())
            : null
      );
    } catch (e) {
      return (status: false, message: e.toString(), id: null);
    }
  }

  static Future<({Document? data, String message, bool status})> readDoc(Dio dio, AccessToken token,
      {required int id}) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/document/$id').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        data: response.statusCode != 200
            ? null
            : Document.fromJson(response.data['data'])
      );
    } catch (e) {
      return (status: false, message: e.toString(), data: null);
    }
  }

  static Future<({String message, bool status})> deleteDoc(
      Dio dio, AccessToken token,
      {required int id}) async {
    try {
      final response = await dio.delete(
          Uri.https(cfg.domain, '/document/$id/delete').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString()
      );
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }
}

typedef DocumentResponse = ({DocumentData? data, String message, bool status});
