import 'package:flutter/material.dart';
import 'package:tm_countries/models/country.dart';

class CountryInfo extends StatelessWidget {
  final Country country;
  const CountryInfo({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${country.emojiFlag} ${country.name.official}",
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
