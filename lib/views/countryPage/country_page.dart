import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:tm_countries/models/country.dart';
import 'package:tm_countries/utils/colors.dart';
import 'package:tm_countries/utils/utils.dart' as utils;
import 'package:tm_countries/views/countryPage/back_button.dart';
// import 'package:flutter_svg/flutter_svg.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CountriesCubit()..fetchNeighbours(widget.country.borders),
        )
      ],
      child: Scaffold(
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
                    _regionSection(context),
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
                    _neighbourCountries(),
                    const SizedBox(
                      height: 40,
                    ),
                    _capitalCityWidget(context,
                        capital: widget.country.capitals![0]),
                    const SizedBox(
                      height: 40,
                    ),
                    _areaAndPopulationSection(context),
                    const SizedBox(
                      height: 40,
                    ),
                    _googleMapsRedirectWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleMapsRedirectWidget() {
    return Center(
      child: TextButton(
        onPressed: () async {
          final String url = widget.country.countryMap!.googleMaps!;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

  Container _areaAndPopulationSection(BuildContext context) {
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
            child: _populationWidget(context,
                population: widget.country.population!),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: _areaWidget(context, area: widget.country.area!),
          )
        ],
      ),
    );
  }

  Widget _populationWidget(
    context, {
    required int population,
  }) {
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

  Widget _areaWidget(BuildContext context, {required double area}) {
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

  Widget _capitalCityWidget(BuildContext context, {required String capital}) {
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

  BlocBuilder<CountriesCubit, CountriesState> _neighbourCountries() {
    return BlocBuilder<CountriesCubit, CountriesState>(
        builder: (BuildContext context, CountriesState state) {
      if (state is NeighbouringCountriesLoadedState) {
        int contHeight = (state.neighbourCountries.length / 2).ceil();
        return Container(
          height: contHeight * 170,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 140),
              itemCount: state.neighbourCountries.length,
              itemBuilder: (BuildContext context, int index) {
                return _neighbourCountryListItem(
                    context, state.neighbourCountries[index]);
              }),
        );
      } else if (state is CountriesLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const Center(
          child: Text("No Neighbours"),
        );
      }
    });
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
          Navigator.of(context).pop();
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

  Row _regionSection(BuildContext context) {
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
                  utils.getRegionImageUrl(widget.country.region),
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
                widget.country.region,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.country.subregion!,
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
