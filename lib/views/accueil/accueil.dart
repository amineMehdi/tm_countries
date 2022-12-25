import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tm_countries/cubit/countries_cubit.dart';
import 'package:tm_countries/cubit/favourites_cubit.dart';
import 'package:tm_countries/views/components/page_header.dart';
import 'package:tm_countries/utils/colors.dart';

import 'package:tm_countries/models/country.dart';
import 'package:tm_countries/views/countryPage/country_page.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageAccueil> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PageHeader(
              title: "Accueil", iconData: Icons.home, iconColor: Colors.blue),
          countriesList(context),
        ],
      ),
    );
  }

  Widget countriesList(BuildContext context) {
    return Builder(builder: (context) {
      CountriesState state = context.watch<CountriesCubit>().state;

      if (state is CountriesLoadedState) {
        return Expanded(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text("${state.countriesData.length.toString()} pays",
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
                itemCount: state.countriesData.length,
                itemBuilder: (context, index) {
                  return countryListItem(context, state.countriesData[index]);
                },
              ),
            ),
          ]),
        );
      } else {
        return Column(children: [
          const Text("No data"),
          FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CountriesCubit>(context).fetchAllCountries();
              },
              child: const Icon(Icons.refresh))
        ]);
      }
    });
  }

  Widget countryListItem(BuildContext context, Country country) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CountryInfo(country: country),
        ));
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(country.countryFlag!.png),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    country.name.common,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.grey),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Builder(builder: (context) {
                  IconData favIcon;
                  String message;
                  if (BlocProvider.of<CountriesCubit>(context)
                      .isFavourite(country)) {
                    favIcon = Icons.favorite;
                    message = "Supprimé des favoris";
                  } else {
                    favIcon = Icons.favorite_outline;
                    message = "Ajouté aux favoris";
                  }
                  return IconButton(
                    splashRadius: 0.1,
                    onPressed: () {
                      if (BlocProvider.of<FavouritesCubit>(context)
                          .isFavourite(country)) {
                        BlocProvider.of<FavouritesCubit>(context)
                            .removeFromFavourites(country);
                        BlocProvider.of<CountriesCubit>(context)
                            .toggleFavourite(country);
                      } else {
                        BlocProvider.of<FavouritesCubit>(context)
                            .addToFavourites(country);
                        BlocProvider.of<CountriesCubit>(context)
                            .toggleFavourite(country);
                      }

                      Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 18,
                        backgroundColor: CustomColors.darkGrey,
                        textColor: Colors.white,
                        webPosition: "center",
                        webBgColor: "#595959",
                      );
                    },
                    icon: Icon(favIcon, color: Colors.lime),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
