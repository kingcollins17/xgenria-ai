// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
      chatId: json['chat_id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      settings: json['settings'],
      totalMessages: json['total_messages'] as int,
      usedTokens: json['used_tokens'] as int,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      lastDatetime: json['last_datetime'] == null
          ? null
          : DateTime.parse(json['last_datetime'] as String),
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'chat_id': instance.chatId,
      'user_id': instance.userId,
      'name': instance.name,
      'settings': instance.settings,
      'total_messages': instance.totalMessages,
      'used_tokens': instance.usedTokens,
      'datetime': instance.datetime?.toIso8601String(),
      'last_datetime': instance.lastDatetime?.toIso8601String(),
    };

ChatBubbleData _$ChatBubbleDataFromJson(Map<String, dynamic> json) =>
    ChatBubbleData(
      chatMessageId: json['chat_message_id'] as int?,
      chatId: json['chat_id'] as int?,
      model: json['model'] as String?,
      apiResponseTime: json['api_response_time'] as int?,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChatBubbleDataToJson(ChatBubbleData instance) =>
    <String, dynamic>{
      'chat_message_id': instance.chatMessageId,
      'chat_id': instance.chatId,
      'role': instance.role,
      'content': instance.content,
      'model': instance.model,
      'api_response_time': instance.apiResponseTime,
      'datetime': instance.datetime?.toIso8601String(),
    };
