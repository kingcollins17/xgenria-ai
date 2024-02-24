import 'package:dio/dio.dart';
import 'package:xgenria/models/image.dart';
import '../models/access_token.dart';

import '_config.dart' as cfg;

abstract class ImageAPI {
  static Future<List<ImageData>?> images(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/images').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((e) => ImageData.fromJson(e))
            .toList();
      }
      return null;
    } on DioException catch (_) {
    } catch (e) {
      return null;
    }
  }

  static Future<({ImageData? data, String message, bool status})> readImage(
    Dio dio,
    AccessToken token,
    int imageId,
  ) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/image/$imageId').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        data: response.statusCode == 200
            ? ImageData.fromJson(response.data['data'])
            : null,
        message: 'Fetched'
      );
    } on DioException catch (_) {
      return (status: false, data: null, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, data: null, message: e.runtimeType.toString());
    }
  }

  static Future<({String message, bool status})> deleteImage(
    Dio dio,
    AccessToken token,
    int imageId,
  ) async {
    try {
      final response = await dio.delete(
          Uri.https(cfg.domain, '/image/$imageId/delete').toString(),
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

  static Future<CreateImageResponse> createImage(
    Dio dio,
    AccessToken token, {
    String name = 'Test Image',
    required String input,
    String style = '3D Render',
    String size = '1024x1024',
    String? lighting,
    String? mood,
    String? artist,
    int variants = 1,
    int? projectId,
  }) async {
    try {
      final response =
          await dio.post(Uri.https(cfg.domain, '/image/create').toString(),
              data: {
                'name': name,
                'input': input,
                'style': style,
                'size': size,
                'lighting': lighting,
                'artist': artist,
                'mood': mood,
                'variants': variants,
                if (projectId != null) 'project_id': projectId
              },
              options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        data: response.data['data'] as Map<String, dynamic>?,
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage, data: null);
    } catch (e) {
      // return e;
      return (status: false, message: e.runtimeType.toString(), data: null);
    }
  }
}

typedef CreateImageResponse = ({
  bool status,
  String message,
  Map<String, dynamic>? data
});
