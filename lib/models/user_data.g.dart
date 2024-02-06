// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: json['userId'] as int?,
      email: json['email'] as String,
      name: json['name'] as String,
      apiKey: json['api_key'] as String?,
      tokenCode: json['token_code'] as String?,
      planId: json['plan_id'] as String?,
      planTrialDone: json['plan_trial_done'] as int?,
      planExpiryDate: json['plan_expiry_date'] as String?,
      referralKey: json['referral_key'] as String?,
      language: json['language'] as String?,
      paymentSubscriptionId: json['payment_subscription_id'] as String?,
      planSettings: json['plan_settings'] == null
          ? null
          : PlanSettingsData.fromJson(
              json['plan_settings'] as Map<String, dynamic>),
      billing: json['billing'] == null
          ? null
          : BillingData.fromJson(json['billing'] as Map<String, dynamic>),
      lastUserAgent: json['last_user_agent'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'api_key': instance.apiKey,
      'token_code': instance.tokenCode,
      'plan_id': instance.planId,
      'plan_trial_done': instance.planTrialDone,
      'plan_expiry_date': instance.planExpiryDate,
      'referral_key': instance.referralKey,
      'language': instance.language,
      'payment_subscription_id': instance.paymentSubscriptionId,
      'last_user_agent': instance.lastUserAgent,
      'plan_settings': instance.planSettings,
      'billing': instance.billing,
    };

PlanSettingsData _$PlanSettingsDataFromJson(Map<String, dynamic> json) =>
    PlanSettingsData(
      documentsModel: json['documents_model'] as String?,
      chatsModel: json['chats_model'] as String?,
      documentsLimit: json['documents_limit'] as int?,
      wordsPerMonthLimit: json['words_per_month_limit'] as int?,
      imagesPerMonthLimit: json['images_per_month_limit'] as int?,
      transcriptionsPerMonthLimit:
          json['transcriptions_per_month_limit'] as int?,
      transcriptionsFileSizeLimit:
          json['transcriptions_file_size_limit'] as int?,
      chatsPerMonthLimit: json['chats_per_month_limit'] as int?,
      projectsLimit: json['projects_limit'] as int?,
      chatMessagesPerChatLimit: json['chat_messages_per_chat_limit'] as int?,
      teamsLimit: json['teams_limit'] as int,
      noAds: json['no_ads'] as bool,
    );

Map<String, dynamic> _$PlanSettingsDataToJson(PlanSettingsData instance) =>
    <String, dynamic>{
      'documents_model': instance.documentsModel,
      'chats_model': instance.chatsModel,
      'documents_limit': instance.documentsLimit,
      'words_per_month_limit': instance.wordsPerMonthLimit,
      'images_per_month_limit': instance.imagesPerMonthLimit,
      'transcriptions_per_month_limit': instance.transcriptionsPerMonthLimit,
      'transcriptions_file_size_limit': instance.transcriptionsFileSizeLimit,
      'chats_per_month_limit': instance.chatsPerMonthLimit,
      'projects_limit': instance.projectsLimit,
      'chat_messages_per_chat_limit': instance.chatMessagesPerChatLimit,
      'teams_limit': instance.teamsLimit,
      'no_ads': instance.noAds,
    };

BillingData _$BillingDataFromJson(Map<String, dynamic> json) => BillingData(
      type: json['type'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      county: json['county'] as String,
      phone: json['phone'] as String,
      taxId: json['tax_id'] as String,
    );

Map<String, dynamic> _$BillingDataToJson(BillingData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'county': instance.county,
      'phone': instance.phone,
      'tax_id': instance.taxId,
    };
