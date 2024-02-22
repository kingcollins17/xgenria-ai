// ignore_for_file: library_private_types_in_public_api

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/models/transcription.dart';
import 'package:xgenria/providers/providers.dart';

part 'trans_provider.g.dart';

@Riverpod(keepAlive: true)
class TransNotifier extends _$TransNotifier {
  @override
  Future<_Data> build(AccessToken token) =>
      TranscriptionAPI.transcriptions(ref.read(dioProvider), token);

  Future<dynamic> delete(int id) =>
      TranscriptionAPI.delete(ref.read(dioProvider), token, id: id);
}

typedef _Data = ({List<TranscriptionData>? data, String message, bool status});
