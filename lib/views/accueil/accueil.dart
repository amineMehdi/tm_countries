import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_countries/cubit/countries_cubit.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageAccueil> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountriesCubit(),
        )
      ],
      child: BlocBuilder<CountriesCubit, CountriesState>(
          builder: (context, state) {
        if (state is CountriesLoadedState) {
          return Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.countriesData.length.toString()),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: state.countriesData.length,
                      itemBuilder: (context, index) {
                        return countryListItem(state, index);
                      },
                    ),
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        // BlocProvider.of<CountriesCubit>(context)
                        //     .fetchACountry(name: 'peru');
                        BlocProvider.of<CountriesCubit>(context)
                            .fetchAllCountries();
                      },
                      child: const Icon(Icons.refresh))
                ]),
          );
        } else {
          return Column(children: [
            const Text("No data"),
            FloatingActionButton(
                onPressed: () {
                  // BlocProvider.of<CountriesCubit>(context)
                  //     .fetchACountry(name: 'peru');
                  BlocProvider.of<CountriesCubit>(context).fetchAllCountries();
                },
                child: const Icon(Icons.refresh))
          ]);
        }
      }),
    );
  }

  Widget countryListItem(CountriesLoadedState state, int index) {
    return Card(
        child: SizedBox(
      width: 100,
      child: Text(state.countriesData[index].name.common),
    ));
  }
}