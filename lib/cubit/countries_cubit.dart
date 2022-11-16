import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitialState());

  Future<void> fetchCountries() async {
    emit(CountriesLoadingState());
    try {
      var response = await Dio().get("https://restcountries.com/v3.1/all");
      emit(CountriesLoadedState(countries: response.data));
    } catch (e) {
      emit(CountriesErrorState(message: e.toString()));
    }
  }
}