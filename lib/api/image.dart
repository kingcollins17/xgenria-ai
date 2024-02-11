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
    } catch (e) {
      return null;
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
                'mood': mood
              },
              options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        data: response.data['data'] as Map<String, dynamic>?,
      );
    } catch (e) {
      // return e;
      return (status: false, message: e.toString(), data: null);
    }
  }
}

typedef CreateImageResponse = ({
  bool status,
  String message,
  Map<String, dynamic>? data
});
