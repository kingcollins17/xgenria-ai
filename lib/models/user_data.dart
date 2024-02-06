import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final int? userId;
  final String email, name;

  @JsonKey(name: 'api_key')
  final String? apiKey;

  @JsonKey(name: 'token_code')
  final String? tokenCode;

  @JsonKey(name: 'plan_id')
  final String? planId;

  @JsonKey(name: 'plan_trial_done')
  final int? planTrialDone;

  @JsonKey(name: 'plan_expiry_date')
  final String? planExpiryDate;

  @JsonKey(name: 'referral_key')
  final String? referralKey;

  final String? language;

  @JsonKey(name: 'payment_subscription_id')
  final String? paymentSubscriptionId;

  @JsonKey(name: 'last_user_agent')
  final String? lastUserAgent;

  @JsonKey(name: 'plan_settings')
  final PlanSettingsData? planSettings;

  final BillingData? billing;

  UserData({
    required this.userId,
    required this.email,
    required this.name,
    required this.apiKey,
    required this.tokenCode,
    required this.planId,
    required this.planTrialDone,
    required this.planExpiryDate,
    required this.referralKey,
    required this.language,
    required this.paymentSubscriptionId,
    required this.planSettings,
    required this.billing,
    required this.lastUserAgent,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  @override
  String toString() => 'UserData${toJson()}';
}

@JsonSerializable()
class PlanSettingsData {
  @JsonKey(name: 'documents_model')
  final String? documentsModel;

  @JsonKey(name: 'chats_model')
  final String? chatsModel;

  @JsonKey(name: 'documents_limit')
  final int? documentsLimit;

  @JsonKey(name: 'words_per_month_limit')
  final int? wordsPerMonthLimit;

  @JsonKey(name: 'images_per_month_limit')
  final int? imagesPerMonthLimit;

  @JsonKey(name: 'transcriptions_per_month_limit')
  final int? transcriptionsPerMonthLimit;

  @JsonKey(name: 'transcriptions_file_size_limit')
  final int? transcriptionsFileSizeLimit;

  @JsonKey(name: 'chats_per_month_limit')
  final int? chatsPerMonthLimit;

  @JsonKey(name: 'projects_limit')
  final int? projectsLimit;

  @JsonKey(name: 'chat_messages_per_chat_limit')
  final int? chatMessagesPerChatLimit;

  @JsonKey(name: 'teams_limit')
  final int teamsLimit;

  @JsonKey(name: 'no_ads')
  final bool noAds;

  PlanSettingsData(
      {required this.documentsModel,
      required this.chatsModel,
      required this.documentsLimit,
      required this.wordsPerMonthLimit,
      required this.imagesPerMonthLimit,
      required this.transcriptionsPerMonthLimit,
      required this.transcriptionsFileSizeLimit,
      required this.chatsPerMonthLimit,
      required this.projectsLimit,
      required this.chatMessagesPerChatLimit,
      required this.teamsLimit,
      required this.noAds});

  factory PlanSettingsData.fromJson(Map<String, dynamic> json) =>
      _$PlanSettingsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PlanSettingsDataToJson(this);

  @override
  String toString() => 'PlanSettingsData${toJson()}';
}

@JsonSerializable()
class BillingData {
  final String type, name, address, city, county, phone;

  @JsonKey(name: 'tax_id')
  final String taxId;

  BillingData(
      {required this.type,
      required this.name,
      required this.address,
      required this.city,
      required this.county,
      required this.phone,
      required this.taxId});

  factory BillingData.fromJson(Map<String, dynamic> json) =>
      _$BillingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BillingDataToJson(this);

  @override
  String toString() => 'BillingData${toJson()}';
}
