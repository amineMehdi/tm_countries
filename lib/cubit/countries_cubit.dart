import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:tm_countries/models/country.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitialState());

  Future<void> fetchAllCountries() async {
    emit(CountriesLoadingState());

    try {
      List<Country> countriesData = [];
      // var response = await Dio().get("https://restcountries.com/v3.1/all");

      // countriesData = (response.data as List)
      //     .map((country) => Country.fromJson(country))
      //     .toList();

      // TODO change to remote api
      var response = await rootBundle.loadString('countries.json');
      countriesData = (jsonDecode(response) as List)
          .map((country) => Country.fromJson(country))
          .toList();

      emit(CountriesLoadedState(countriesData: countriesData));
    } catch (e) {
      emit(CountriesErrorState(message: e.toString()));
      print("Error : $e");
    }
  }

  Future<void> fetchNeighbours(List<String>? borders) async {
    try {
      List<Country> countriesData = [];
      for (var border in borders!) {
        var response = await Dio()
            .get("https://restcountries.com/v3.1/alpha?codes=$border");
        if (response.statusCode == 200) {
          Country countryData = Country.fromJson(response.data[0]);
          countriesData.add(countryData);
          print("$border ${countryData.name.common}");
        }
      }
      emit(NeighbouringCountriesLoadedState(neighbourCountries: countriesData));
    } catch (e) {
      emit(CountriesErrorState(message: e.toString()));
      print("Error : $e");
    }
  }

  @override
  void onChange(Change<CountriesState> change) {
    super.onChange(change);
    print(state.toString());
  }

  void toggleFavourite(Country country) {
    if (state is! CountriesLoadedState) return;
    CountriesLoadedState currentState = state as CountriesLoadedState;
    int countryIndex = currentState.countriesData.indexWhere((otherCountries) =>
        otherCountries.name.official == country.name.official);
    currentState.countriesData[countryIndex].isFavourite = isFavourite(country) ? false : true;
    
    emit(CountriesLoadedState(countriesData: currentState.countriesData));
  }

  bool isFavourite(Country country) {
    if (state is! CountriesLoadedState) return false;
    return (state as CountriesLoadedState)
        .countriesData[(state as CountriesLoadedState).countriesData.indexWhere(
            (otherCountries) =>
                otherCountries.name.official == country.name.official)]
        .isFavourite;
  }
}
