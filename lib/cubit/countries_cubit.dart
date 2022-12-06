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
    emit(CountriesLoadingState());

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
      // borders?.forEach((border) async {
        // var response = await Dio()
        //     .get("https://restcountries.com/v3.1/alpha?codes=$border");
        // if (response.statusCode == 200) {
        //   Country countryData = Country.fromJson(response.data[0]);
        //   countriesData.add(countryData);
        //   print("$border ${countryData.name.common}");
        // }
      // });
      emit(NeighbouringCountriesLoadedState(neighbourCountries: countriesData));
    } catch (e) {
      emit(CountriesErrorState(message: e.toString()));
      print("Error : $e");
    }

    //   try {
    //   var response =
    //       await Dio().get("https://restcountries.com/v3.1/name/$name");
    //   if (response.statusCode == 200) {
    //     Country countryData;

    //     Map<String, dynamic> country = response.data[0];
    //     countryData = Country.fromJson(country);
    //     emit(CountriesLoadedState(countriesData: [countryData]));
    //   } else {
    //     emit(CountriesErrorState(message: "Failed loading country"));
    //   }
    // } catch (e) {
    //   emit(CountriesErrorState(message: e.toString()));
    // }
  }

  @override
  void onChange(Change<CountriesState> change) {
    super.onChange(change);
    print(change);
  }
}
