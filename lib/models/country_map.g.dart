// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryMap _$CountryMapFromJson(Map<String, dynamic> json) => CountryMap(
      googleMaps: json['googleMaps'] as String?,
      openstreetmap: json['openstreetmap'] as String?,
    );

Map<String, dynamic> _$CountryMapToJson(CountryMap instance) =>
    <String, dynamic>{
      'googleMaps': instance.googleMaps,
      'openstreetmap': instance.openstreetmap,
    };
