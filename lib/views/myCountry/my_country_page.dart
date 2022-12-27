import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:tm_countries/cubit/countries_cubit.dart';
import 'package:tm_countries/cubit/my_country/my_country_cubit.dart';
import 'package:tm_countries/views/components/page_header.dart';
import 'package:tm_countries/views/countryPage/country_page.dart';

class MyCountryPage extends StatefulWidget {
  const MyCountryPage({super.key});

  @override
  State<MyCountryPage> createState() => _MyCountryPageState();
}

class _MyCountryPageState extends State<MyCountryPage> {
  var location = Location();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => MyCountryCubit()..getMyCountry()),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(
                  title: "My Country",
                  iconData: Icons.location_on,
                  iconColor: Colors.teal),
              const SizedBox(
                height: 20,
              ),
              // TextButton(
              //   onPressed: () =>
              //       BlocProvider.of<MyCountryCubit>(context).getMyCountry(),
              //   child: const Text("Refresh"),
              // ),
              BlocBuilder<MyCountryCubit, MyCountryState>(
                  builder: (context, state) {
                if (state is MyCountryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MyCountryErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is MyCountryLoadedState) {
                  return Column(
                    children: [
                      Text(
                        state.country.name.common,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        state.country.name.official,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        state.country.emojiFlag!,
                        style: const TextStyle(fontSize: 50),
                      ),
                      RegionWidget(country: state.country),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Neighbouring Countries",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .merge(const TextStyle(color: Colors.teal)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      NeighbourCountries(
                        country: state.country,
                        crossAxisCount: MediaQuery.of(context).size.width > 600
                            ? (MediaQuery.of(context).size.width > 1200 ? 4 : 3)
                            : 2,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    CapitalCityWidget(
                                        capital: state.country.capitals![0]),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    GoogleMapsWidget(
                                      countryMap: state.country.countryMap!,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: AreaAndPopluation(
                                    area: state.country.area!,
                                    population: state.country.population!),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            CapitalCityWidget(
                                capital: state.country.capitals![0]),
                            const SizedBox(
                              height: 40,
                            ),
                            AreaAndPopluation(
                                area: state.country.area!,
                                population: state.country.population!),
                            const SizedBox(
                              height: 40,
                            ),
                            GoogleMapsWidget(
                              countryMap: state.country.countryMap!,
                            ),
                          ],
                        );
                      }),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("No data"),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
