import 'package:json_annotation/json_annotation.dart';
import 'package:tm_countries/models/country_name.dart';
import 'package:tm_countries/models/country_map.dart';
import 'package:tm_countries/models/country_flag.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class Country {

  @JsonKey(name: 'name')
  final CountryName name;
  @JsonKey(name: 'region')
  final String region;
  @JsonKey(name: 'subregion')
  final String? subregion;

  @JsonKey(name: 'cioc')
  final String? codeName;
  @JsonKey(name: 'cca3')
  final String? cca3;
  
  @JsonKey(name: 'capital')
  final List<String>? capitals;
  @JsonKey(name: 'borders')
  final List<String>? borders;
  @JsonKey(name: 'area')
  final double? area;

  @JsonKey(name: 'flag')
  final String? emojiFlag;
  @JsonKey(name: 'population')
  final int? population;

  @JsonKey(name: 'maps')
  final CountryMap? countryMap;
  @JsonKey(name: 'continents')
  final List<String>? continents;

  @JsonKey(name: 'flags')
  final CountryFlag? countryFlag;

  bool isFavourite = false;
  Country({
    required this.name,
    required this.region,
    this.subregion,
    this.codeName,
    this.capitals,
    this.area,
    this.countryMap,
    this.continents,
    this.countryFlag,
    this.population,
    this.emojiFlag,
    this.borders,
    this.cca3,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
