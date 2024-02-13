import 'package:dio/dio.dart';
import 'package:xgenria/models/chat.dart';
import '../models/access_token.dart';

import '_config.dart' as cfg;

typedef CreateChatResponse = ({bool status, String message, int? id});
typedef FetchChatResponse = ({
  List<ChatData>? data,
  String message,
  bool status
});

typedef TalkResponse = ({ChatBubbleData? data, bool status, String message});
typedef FetchMessageResponse = ({
  List<ChatBubbleData>? data,
  String message,
  bool status
});

abstract class ChatAPI {
  static Future<FetchChatResponse> chats(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, 'chats').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        data: response.statusCode == 200
            ? (response.data as List<dynamic>)
                .map((e) => ChatData.fromJson(e))
                .toList()
            : null,
        message: response.statusCode == 200
            ? 'Fetched chats'
            : response.data['message'].toString()
      );
    } catch (e) {
      return (status: false, data: null, message: e.toString());
    }
  }

  static Future<FetchMessageResponse> messages(Dio dio, AccessToken token,
      {required int chatId}) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/chat/$chatId/messages').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        data: response.statusCode == 200
            ? (response.data['data'] as List<dynamic>)
                .map((e) => ChatBubbleData.fromJson(e))
                .toList()
            : null
      );
    } catch (e) {
      return (status: false, data: null, message: e.toString());
    }
  }

  static Future<TalkResponse> talk(Dio dio, AccessToken token,
      {required int chatId, required String content}) async {
    try {
      final response = await dio.post(
          Uri.https(cfg.domain, '/chat/$chatId/talk').toString(),
          data: {'content': content},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        data: response.statusCode == 200
            ? ChatBubbleData.fromJson(response.data['data'])
            : null
      );
      // return response.data;
    } catch (e) {
      return (status: false, data: null, message: e.toString());
    }
  }

  static Future<CreateChatResponse> createChat(Dio dio, AccessToken token,
      {required String chatName}) async {
    try {
      final response =
          await dio.post(Uri.https(cfg.domain, '/chat/create').toString(),
              data: {'name': chatName},
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      // return response.data;
      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
        id: response.statusCode == 200
            ? response.data['data']['id'] as int
            : null
      );
    } catch (e) {
      return (status: false, message: e.toString(), id: null);
    }
  }
}
