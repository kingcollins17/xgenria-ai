import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'user_data.dart';

part 'plan.g.dart';

@JsonSerializable()
class PlanData {
  @JsonKey(name: 'plan_id')
  final int planId;

  final String name;

  @JsonKey(name: 'monthly_price')
  final double monthlyPrice;

  @JsonKey(name: 'trial_days')
  final int trialDays;

  final dynamic settings;

  PlanSettingsData get planSettings =>
      PlanSettingsData.fromJson(jsonDecode(settings));

  factory PlanData.fromJson(Map<String, dynamic> json) =>
      _$PlanDataFromJson(json);

  PlanData({
    required this.planId,
    required this.name,
    required this.monthlyPrice,
    required this.trialDays,
    required this.settings,
  });
  Map<String, dynamic> toJson() => _$PlanDataToJson(this);

  @override
  toString() => 'PlanData{id: $planId, name: $name, settings: $planSettings}';
}
