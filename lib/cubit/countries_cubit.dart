import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_countries/models/country.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitialState());

  static CountriesCubit get(context) => BlocProvider.of(context);

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

  Future<List<Country>> fetchNeighbours(List<String>? borders) async {
    print("fetching neighbours : ${state.toString()}}");
    try {
      List<Country> neighbourCountries = [];
      if (state is CountriesLoadedState) {
        List<Country> allCountries =
            (state as CountriesLoadedState).countriesData;
        // print(
        // "[$state] fetching neighbours from local data ${allCountries.length}");
        for (var border in borders!) {
          var country = allCountries.firstWhere(
            (country) => country.codeName == border || country.cca3 == border,
          );
          print("found neighbour : ${country.name.official}");
          neighbourCountries.add(country);
        }
        print("Fetched neighbours : ${neighbourCountries.length}");
        return Future.value(neighbourCountries);
      }
      for (var border in borders!) {
        print("fetching neighbours from api");
        var response = await Dio()
            .get("https://restcountries.com/v3.1/alpha?codes=$border");
        if (response.statusCode == 200) {
          Country countryData = Country.fromJson(response.data[0]);
          neighbourCountries.add(countryData);
        }
      }
      return Future.value(neighbourCountries);
    } catch (e) {
      print("Error : $e");
      rethrow;
    }
  }

  @override
  void onChange(Change<CountriesState> change) {
    super.onChange(change);
    // print(state.toString());
  }

  void toggleFavourite(Country country) {
    if (state is! CountriesLoadedState) return;
    CountriesLoadedState currentState = state as CountriesLoadedState;
    int countryIndex = currentState.countriesData.indexWhere((otherCountries) =>
        otherCountries.name.official == country.name.official);
    currentState.countriesData[countryIndex].isFavourite =
        isFavourite(country) ? false : true;

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
