import 'package:json_annotation/json_annotation.dart';
import 'package:tm_countries/models/country_name.dart';
import 'package:tm_countries/models/country_map.dart';
import 'package:tm_countries/models/country_flag.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  final CountryName name;

  final String region;

  final String? subregion;

  @JsonKey(name: 'cioc')
  final String? codeName;

  @JsonKey(name: 'capital')
  final List<String>? capitals;

  final List<String>? borders;

  final double? area;

  @JsonKey(name: 'flag')
  final String? emojiFlag;

  final int? population;

  @JsonKey(name: 'maps')
  final CountryMap? countryMap;


  final List<String>? continents;
  
  @JsonKey(name: 'flags')
  final CountryFlag? countryFlag;
  
  Country ({
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
  });


  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}