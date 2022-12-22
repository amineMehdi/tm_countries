part of 'my_country_cubit.dart';

abstract class MyCountryState {

}

class MyCountryInitial extends MyCountryState {}

class MyCountryLoading extends MyCountryState {}

class MyCountryLoadedState extends MyCountryState {
  final Country country;

  MyCountryLoadedState(this.country);
}

class MyCountryErrorState extends MyCountryState {
  final String message;

  MyCountryErrorState(this.message);
}