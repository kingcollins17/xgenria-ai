import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/models/image.dart';
import 'package:xgenria/providers/providers.dart';

part 'image_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<ImageData>?> images(ImagesRef ref, AccessToken token) async =>
    ImageAPI.images(ref.read(dioProvider), token);
