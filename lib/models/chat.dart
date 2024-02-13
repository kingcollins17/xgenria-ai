import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatData {
  @JsonKey(name: 'chat_id')
  final int chatId;

  @JsonKey(name: 'user_id')
  final int userId;

  final String name;

  final dynamic settings;

  @JsonKey(name: 'total_messages')
  final int totalMessages;

  @JsonKey(name: 'used_tokens')
  final int usedTokens;

  final DateTime? datetime;

  @JsonKey(name: 'last_datetime')
  final DateTime? lastDatetime;

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  ChatData(
      {required this.chatId,
      required this.userId,
      required this.name,
      required this.settings,
      required this.totalMessages,
      required this.usedTokens,
      required this.datetime,
      required this.lastDatetime});
  Map<String, dynamic> toJson() => _$ChatDataToJson(this);

  @override
  String toString() =>
      'ChatData{chatId: $chatId, userId: $userId, name: $name, settings: $settings, '
      'totalMessages: $totalMessages, datetime; $datetime, usedTokens: $usedTokens}';
}

@JsonSerializable()
class ChatBubbleData {
  @JsonKey(name: 'chat_message_id')
  final int? chatMessageId;

  @JsonKey(name: 'chat_id')
  final int? chatId;

  final String role, content;

  final String? model;
  @JsonKey(name: 'api_response_time')
  final int? apiResponseTime;

  final DateTime? datetime;
  factory ChatBubbleData.fromJson(Map<String, dynamic> json) =>
      _$ChatBubbleDataFromJson(json);

  ChatBubbleData(
      {this.chatMessageId,
      this.chatId,
      this.model,
      this.apiResponseTime,
      this.datetime,
      required this.role,
      required this.content});
  Map<String, dynamic> toJson() => _$ChatBubbleDataToJson(this);

  bool operator >(ChatBubbleData other) {
    if (chatMessageId != null && other.chatMessageId != null) {
      return chatMessageId! > other.chatMessageId!;
    }
    return true;
  }

  @override
  bool operator ==(Object other) {
    return (other is ChatBubbleData) &&
        (identical(this, other) ||
            (chatMessageId == other.chatMessageId &&
                chatId == other.chatId &&
                content == other.content));
  }

  @override
  String toString() =>
      'ChatBubbleData{id: $chatMessageId, chatId: $chatId, role: $role,'
      ' content: $content, model: $model, datetime: $datetime}';

  @override
  int get hashCode => content.hashCode ^ role.hashCode;
}
