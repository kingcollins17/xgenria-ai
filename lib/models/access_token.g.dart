// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      type: json['token_type'] as String?,
      value: json['access_token'] as String,
      expiration: json['expires_in'] == null
          ? null
          : Duration(microseconds: json['expires_in'] as int),
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.value,
      'token_type': instance.type,
      'expires_in': instance.expiration?.inMicroseconds,
    };
