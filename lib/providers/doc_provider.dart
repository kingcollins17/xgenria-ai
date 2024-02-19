import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/models.dart';
import 'package:xgenria/providers/providers.dart';

part 'doc_provider.g.dart';

@riverpod
class DocNotifier extends _$DocNotifier {
  @override
  Future<DocumentData?> build(AccessToken token) async {
    final res = await DocumentAPI.documents(ref.read(dioProvider), token);
    if (!res.status) throw Exception(res.message);

    return res.data!;
  }

  Future<(bool, String, int?)> createDoc(
      {required String name,
      required String input,
      int templateId = 38}) async {
    final res = await DocumentAPI.createDoc(ref.read(dioProvider), token,
        name: name, text: input, type: templateId);

    if (res.status) {
      ref.invalidate(docNotifierProvider);
      await future;
    }
    return (res.status, res.message, res.id);
  }

  Future<bool> deleteDoc(int id) async {
    final res = await DocumentAPI.deleteDoc(
      ref.read(dioProvider),
      token,
      id: id,
    );
    if (res.status) {
      ref.invalidate(docNotifierProvider);
      await future;
    }

    return res.status;
  }
}
