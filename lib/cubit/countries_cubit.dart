import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tm_countries/models/country.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitialState());

  Future<void> fetchAllCountries() async {
    emit(CountriesLoadingState());

    try {
      // var response = await http.get(
      //     Uri.parse("https://restcountries.com/v3.1/all"),
      //     headers: {"Accept": "application/json"});
      List<Country> countriesData = [];
      var response = await rootBundle.loadString('countries.json');
      List<dynamic> responseData = json.decode(response);

      countriesData = responseData
          .map((country) => Country.fromJson(country))
          .toList();

      emit(CountriesLoadedState(countriesData: countriesData));
    } catch (e) {
      emit(CountriesErrorState(message: e.toString()));
      print("Error : $e");
    }
  }

  Future<void> fetchACountry({required String name}) async {
    emit(CountriesLoadingState());
    try {
      var response = await http
          .get(Uri.parse('https://restcountries.com/v3.1/name/$name'), //url
              headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        Country countryData;

        Map<String, dynamic> country = jsonDecode(response.body)[0];
        countryData = Country.fromJson(country);
        emit(CountriesLoadedState(countriesData: [countryData]));
        print(countryData.toString());
      } else {
        emit(CountriesErrorState(message: "Failed loading country"));
      }
      // Country countryData;
      // print("Response code :  " + response.statusCode.toString());
      //
      // Map<String, dynamic> country = jsonDecode(response.body)[0];
      // print(country);
      // countryData = Country.fromJson(country);
    } catch (e) {
      emit(CountriesErrorState(message: e.toString()));
      print("Error : " + e.toString());
    }
  }

  @override
  void onChange(Change<CountriesState> change) {
    super.onChange(change);
    // print(change);
  }
}
