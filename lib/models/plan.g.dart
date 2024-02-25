// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanData _$PlanDataFromJson(Map<String, dynamic> json) => PlanData(
      planId: json['plan_id'] as int,
      name: json['name'] as String,
      monthlyPrice: (json['monthly_price'] as num).toDouble(),
      trialDays: json['trial_days'] as int,
      settings: json['settings'],
    );

Map<String, dynamic> _$PlanDataToJson(PlanData instance) => <String, dynamic>{
      'plan_id': instance.planId,
      'name': instance.name,
      'monthly_price': instance.monthlyPrice,
      'trial_days': instance.trialDays,
      'settings': instance.settings,
    };
