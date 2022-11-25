import 'package:json_annotation/json_annotation.dart';

part 'country_map.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryMap {
  final String? googleMaps;
  final String? openstreetmap;

  CountryMap({
    this.googleMaps,
    this.openstreetmap,
  });

  factory CountryMap.fromJson(Map<String, dynamic> json) => _$CountryMapFromJson(json);
  Map<String, dynamic> toJson() => _$CountryMapToJson(this);
}