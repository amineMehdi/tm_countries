import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_countries/models/country.dart';
import 'package:tm_countries/utils/colors.dart';
import 'package:tm_countries/utils/utils.dart' as utils;
import 'package:tm_countries/views/countryPage/back_button.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:tm_countries/cubit/countries_cubit.dart';

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.country.countryFlag!.png),
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
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      decoration: BoxDecoration(
                        color: CustomColors.grey.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 100,
                      width: double.infinity,
                      child: BlocBuilder<CountriesCubit, CountriesState>(
                          builder:
                              (BuildContext context, CountriesState state) {
                        if (state is NeighbouringCountriesLoadedState) {
                          // return GridView.count(
                          //   crossAxisCount: 3,
                          //   childAspectRatio: 2.5,
                          //   crossAxisSpacing: 10,
                          //   mainAxisSpacing: 10,
                          //   children: [
                          //     Text("${state.countriesData.length}"),
                          //     ...state.countriesData
                          //         .map((country) =>
                          //             _neighborCountryListItem(context, country))
                          //         .toList(),
                          //   ],
                          // );
                          // children: state.countriesData
                          //     .map((country) => _neighborCountryListItem(context, country))
                          //     .toList(),

                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: state.countriesData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text("${state.countriesData.length}");
                              });
                        } else {
                          return const Center(
                            child: Text("No Neighbours"),
                          );
                        }
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _neighborCountryListItem(BuildContext context, Country country) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      constraints: const BoxConstraints(minWidth: 120),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.16),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text("${country.emojiFlag} ${country.name.common}"),
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
                  image: Svg(
                utils.getRegionImageUrl(widget.country.region),
                color: Colors.blue,
              )),
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
