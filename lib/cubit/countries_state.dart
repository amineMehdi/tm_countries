part of "countries_cubit.dart";

@immutable
abstract class CountriesState{
  get countriesData => CountriesData;
}

class WeatherInitialState extends CountriesState{}

class WeatherLoadingState extends CountriesState{}

class WeatherLoadedState extends CountriesState{
  final CountriesData countriesData;

  WeatherLoadedState({required this.countriesData});

}
