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
