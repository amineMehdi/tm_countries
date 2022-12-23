import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_countries/models/country.dart';
import 'package:tm_countries/models/country_map.dart';
import 'package:tm_countries/utils/colors.dart';
import 'package:tm_countries/utils/utils.dart' as utils;
import 'package:tm_countries/views/countryPage/back_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:tm_countries/cubit/countries_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryInfo extends StatefulWidget {
  final Country country;
  const CountryInfo({super.key, required this.country});

  @override
  State<CountryInfo> createState() => _CountryInfoState();
}

class _CountryInfoState extends State<CountryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Row(
                      children: [
                        CustomBackButton(
                            imageUrl: widget.country.countryFlag!.png),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "${widget.country.emojiFlag} ${widget.country.name.common}",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.country.name.official,
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RegionWidget(country: widget.country),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Neighbouring Countries",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .merge(const TextStyle(color: Colors.blue)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NeighbourCountries(country: widget.country),
                  const SizedBox(
                    height: 40,
                  ),
                  CapitalCityWidget(capital: widget.country.capitals![0]),
                  const SizedBox(
                    height: 40,
                  ),
                  AreaAndPopluation(
                      area: widget.country.area!,
                      population: widget.country.population!),
                  const SizedBox(
                    height: 40,
                  ),
                  GoogleMapsWidget(
                    countryMap: widget.country.countryMap!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _imageHeader() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.country.countryFlag!.png),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AreaAndPopluation extends StatelessWidget {
  const AreaAndPopluation(
      {Key? key, required this.area, required this.population})
      : super(key: key);
  final double area;
  final int population;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: PopulationWidget(population: population),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: AreaWidget(area: area),
          )
        ],
      ),
    );
  }
}

class NeighbourCountries extends StatelessWidget {
  const NeighbourCountries({Key? key, required this.country}) : super(key: key);
  final Country country;

  @override
  Widget build(BuildContext context) {
    if (country.borders == null || country.borders!.isEmpty) {
      return const Center(
        child: Text("No Neighbouring Countries"),
      );
    }
    return FutureBuilder(
        future: CountriesCubit.get(context).fetchNeighbours(country.borders),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error retrieving Neighbouring Countries"),
              );
            }
            List<Country> neighbourCountries = snapshot.data as List<Country>;
            int contHeight = (neighbourCountries.length / 2).ceil();
            return Container(
              height: contHeight * 180,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 140),
                  itemCount: neighbourCountries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _neighbourCountryListItem(
                        context, neighbourCountries[index]);
                  }),
            );
          }
        });
    // return BlocBuilder<CountriesCubit, CountriesState>(
    //     builder: (BuildContext context, CountriesState state) {
    //   if (state is NeighbouringCountriesLoadedState) {
    //     int contHeight = (state.neighbourCountries.length / 2).ceil();
    //     return Container(
    //       height: contHeight * 170,
    //       width: double.infinity,
    //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    //       decoration: BoxDecoration(
    //         color: Colors.teal.withOpacity(0.1),
    //         borderRadius: BorderRadius.circular(15.0),
    //       ),
    //       child: GridView.builder(
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               crossAxisSpacing: 20,
    //               mainAxisSpacing: 20,
    //               mainAxisExtent: 140),
    //           itemCount: state.neighbourCountries.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return _neighbourCountryListItem(
    //                 context, state.neighbourCountries[index]);
    //           }),
    //     );
    //   } else if (state is CountriesLoadingState) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   } else {
    //     return const Center(
    //       child: Text("No Neighbours"),
    //     );
    //   }
    // });
  }

  Widget _neighbourCountryListItem(BuildContext context, Country country) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.36),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        onTap: () {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CountryInfo(country: country)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(country.emojiFlag!, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 15),
            Text(country.name.common,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class RegionWidget extends StatelessWidget {
  const RegionWidget({
    Key? key,
    required this.country,
  }) : super(key: key);
  final Country country;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: svg_provider.Svg(
                  utils.getRegionImageUrl(country.region),
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                country.region,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                country.subregion!,
                style: Theme.of(context).textTheme.headline3!.merge(
                    const TextStyle(
                        fontSize: 24, color: CustomColors.lightGrey)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CapitalCityWidget extends StatelessWidget {
  const CapitalCityWidget({
    Key? key,
    required this.capital,
  }) : super(key: key);

  final String capital;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Flexible(
            child: Icon(Icons.apartment, size: 100, color: Colors.blue),
          ),
          const SizedBox(
            width: 40,
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Capital City",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(TextStyle(color: Colors.blue.withOpacity(0.65))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  capital,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AreaWidget extends StatelessWidget {
  const AreaWidget({
    Key? key,
    required this.area,
  }) : super(key: key);

  final double area;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.straighten,
                  size: 75,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Area",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(const TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            utils.parseArea(area),
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
        ]);
  }
}

class PopulationWidget extends StatelessWidget {
  const PopulationWidget({
    Key? key,
    required this.population,
  }) : super(key: key);
  final int population;

  @override
  Widget build(BuildContext context) {
    final double populationPercentage = population / 800000000;
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: populationPercentage,
                    strokeWidth: 10,
                    backgroundColor: CustomColors.grey.withOpacity(0.16),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 75,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Population",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .merge(const TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            utils.parsePopulation(population),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }
}

class GoogleMapsWidget extends StatelessWidget {
  const GoogleMapsWidget({
    Key? key,
    required this.countryMap,
  }) : super(key: key);
  final CountryMap countryMap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          final String url = countryMap.googleMaps!;
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          backgroundColor: Colors.teal.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.map_outlined, size: 40, color: Colors.teal),
          const SizedBox(
            width: 40,
          ),
          Text("Google Maps", style: Theme.of(context).textTheme.headline3),
          const SizedBox(
            width: 40,
          ),
          const Icon(Icons.launch_outlined, size: 40, color: Colors.teal),
        ]),
      ),
    );
  }
}
