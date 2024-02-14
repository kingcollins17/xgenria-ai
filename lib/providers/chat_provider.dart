import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xgenria/api/api.dart';
import '../models/access_token.dart';
import 'providers.dart';

part 'chat_provider.g.dart';

@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  @override
  Future<FetchChatResponse> build(AccessToken token) =>
      ChatAPI.chats(ref.read(dioProvider), token);

  Future<void> delete(int chatId) async {
    await ChatAPI.deleteChat(ref.read(dioProvider), token, chatId: chatId);
    ref.invalidate(chatNotifierProvider);
    await future;
  }

  ///Returns the id of the chat that was just created
  Future<int?> create(String chatName) async {
    final response = await ChatAPI.createChat(ref.read(dioProvider), token,
        chatName: chatName);
    if (response.status) {
      ref.invalidate(chatNotifierProvider);
      await future;
      return response.id;
    }
    return null;
  }
}
