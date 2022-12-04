import 'package:flutter/material.dart';
import 'package:tm_countries/models/country.dart';
import 'package:tm_countries/utils/utils.dart' as utils;
import 'package:tm_countries/views/countryPage/back_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryInfo extends StatelessWidget {
  final Country country;
  const CountryInfo({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(country.countryFlag!.png),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    children: [
                      CustomBackButton(imageUrl: country.countryFlag!.png),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${country.emojiFlag} ${country.name.common}",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
                Text(
                  country.name.official,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                SvgPicture.asset(
                  utils.getContinentImageUrl(country.region),
                  width: 350,
                  height: 350,
                  color: Colors.blue,
                  fit: BoxFit.cover
                ),
                // Image.asset("images/regions/america.png",
                //   width: 350,
                //   height: 350,
                // ),
                Text(
                  country.region,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
