// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: CountryName.fromJson(json['name'] as Map<String, dynamic>),
      region: json['region'] as String,
      subregion: json['subregion'] as String?,
      codeName: json['cioc'] as String?,
      capitals:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      area: (json['area'] as num?)?.toDouble(),
      countryMap: json['maps'] == null
          ? null
          : CountryMap.fromJson(json['maps'] as Map<String, dynamic>),
      continents: (json['continents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      countryFlag: json['flags'] == null
          ? null
          : CountryFlag.fromJson(json['flags'] as Map<String, dynamic>),
      population: json['population'] as int?,
      emojiFlag: json['flag'] as String?,
      borders:
          (json['borders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cca3: json['cca3'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name.toJson(),
      'region': instance.region,
      'subregion': instance.subregion,
      'cioc': instance.codeName,
      'cca3': instance.cca3,
      'capital': instance.capitals,
      'borders': instance.borders,
      'area': instance.area,
      'flag': instance.emojiFlag,
      'population': instance.population,
      'maps': instance.countryMap?.toJson(),
      'continents': instance.continents,
      'flags': instance.countryFlag?.toJson(),
    };
