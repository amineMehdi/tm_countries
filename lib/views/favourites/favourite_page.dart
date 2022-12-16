import 'package:flutter/material.dart';
import 'package:tm_countries/cubit/favourites_cubit.dart';
import 'package:tm_countries/models/country.dart';
import 'package:tm_countries/utils/colors.dart';
import 'package:tm_countries/views/components/page_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_countries/views/countryPage/country_page.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PageHeader(
              title: "Favoris",
              iconData: Icons.favorite,
              iconColor: Colors.orange),
          _favouritesList(),
        ],
      ),
    );
  }

  Widget _favouritesList() {
    return Builder(builder: (context) {
      FavouritesState state = context.watch<FavouritesCubit>().state;

      if (state is! FavouritesLoadedState || state.countriesData.isEmpty) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Text(
              "Aucun pays favoris",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        );
      }
      return Expanded(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                "${state.countriesData.length.toString()} pays",
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
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
                  return _favouriteListItem(
                      context, state.countriesData[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _favouriteListItem(BuildContext context, Country country) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CountryInfo(country: country),
        ));
      },
      child: Card(
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
    );
  }
}
