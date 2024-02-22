import 'package:json_annotation/json_annotation.dart';

part 'access_token.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'access_token')
  final String value;

  @JsonKey(name: 'token_type')
  final String? type;

  @JsonKey(name: 'expires_in')
  final Duration? expiration;

  AccessToken({
    this.type,
    required this.value,
    this.expiration,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);

  @override
  String toString() => value;
}
