import 'package:json_annotation/json_annotation.dart';

part 'country_flag.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryFlag {
  final String svg;
  final String png;

  CountryFlag({
    required this.svg,
    required this.png,
  });

  factory CountryFlag.fromJson(Map<String, dynamic> json) => _$CountryFlagFromJson(json);
  Map<String, dynamic> toJson() => _$CountryFlagToJson(this);
}