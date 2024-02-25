import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xgenria/models/transcription.dart';
import '../models/access_token.dart';

import '_config.dart' as cfg;

typedef CreateTranscriptionResp = ({int? id, String message, bool status});

abstract class TranscriptionAPI {
  static Future<({List<TranscriptionData>? data, String message, bool status})>
      transcriptions(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/transcriptions').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return (
        status: response.statusCode == 200,
        data: response.statusCode == 200
            ? (response.data as List<dynamic>)
                .map((e) => TranscriptionData.fromJson(e))
                .toList()
            : null,
        message: 'Fetched'
      );
    } on DioException catch (exp) {
      return (status: false, message: cfg.connectErrorMessage, data: null);
    } catch (e) {
      return (status: false, message: 'Something went wrong', data: null);
    }
  }

  static Future<CreateTranscriptionResp> create(Dio dio, AccessToken token,
      {required String name, required File file, int? projectId}) async {
    try {
      var form = FormData();
      form
        ..fields.add(MapEntry('name', name))
        ..files.add(MapEntry('file', await MultipartFile.fromFile(file.path)));
      if (projectId != null) {
        form.fields.add(MapEntry('project_id', '$projectId'));
      }

      final response = await dio.post(
          Uri.https(cfg.domain, '/transcription/create').toString(),
          data: form,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        id: response.statusCode == 200
            ? int.parse(response.data['data']['id'].toString())
            : null
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage, id: null);
    } catch (e) {
      return (status: false, message: e.toString(), id: null);
    }
  }

  static Future<dynamic> readTranscript(
      Dio dio, AccessToken token, int id) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/transcription/$id').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } on DioException catch (_) {
      return cfg.connectErrorMessage;
    } catch (e) {
      return e;
    }
  }

  static Future<({String message, bool status})> delete(
      Dio dio, AccessToken token,
      {required int id}) async {
    try {
      final response = await dio.delete(
          Uri.https(cfg.domain, '/transcription/$id/delete').toString(),
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
