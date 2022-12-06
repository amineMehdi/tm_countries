
part of 'countries_cubit.dart';

@immutable
abstract class CountriesState{
  get countriesData => List<Country>;
}

class CountriesInitialState extends CountriesState{}

class CountriesLoadingState extends CountriesState{}

class CountriesErrorState extends CountriesState{
  final String message;
  CountriesErrorState({required this.message});
}


class CountriesLoadedState extends CountriesState{
  final List<Country> countriesData;
  CountriesLoadedState({required this.countriesData});
}

class NeighbouringCountriesLoadedState extends CountriesState {
  final List<Country> countriesData;
  NeighbouringCountriesLoadedState({required this.countriesData});
}