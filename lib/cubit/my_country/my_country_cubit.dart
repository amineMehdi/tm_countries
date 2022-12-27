import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:tm_countries/models/country.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/foundation.dart' show kIsWeb;
part 'my_country_state.dart';

class MyCountryCubit extends Cubit<MyCountryState> {
  MyCountryCubit() : super(MyCountryInitial());

  Future getMyCountry() async {
    var location = loc.Location();
    if (state is MyCountryLoadedState) {
      print("Already loaded");
      return;
    }
    try {
      emit(MyCountryLoading());
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          emit(MyCountryErrorState("Location service not enabled"));
          return;
        }
      }
      var permission = await location.hasPermission();
      if (permission == loc.PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != loc.PermissionStatus.granted) {
          emit(MyCountryErrorState("Location permission not granted"));
          return;
        }
      }
      var locationData = await location.getLocation();
      Country? country = await _getCountryByLocation(
          locationData.longitude, locationData.latitude);
      if (country == null) {
        emit(MyCountryErrorState("No country found"));
        return;
      }
      emit(MyCountryLoadedState(country));
    } catch (e) {
      emit(MyCountryErrorState("Error : ${e.toString()}"));
    }
  }

  Future<Country?> _getCountryByLocation(
      double? longitude, double? latitude) async {
    if (longitude == null || latitude == null) {
      return null;
    }
    String country = "";
    if (kIsWeb) {
      var response = await Dio().get("http://ip-api.com/json");
      country = response.data["countryCode"];
    } else {
      await placemarkFromCoordinates(latitude, longitude).then((adresses) {
        country = adresses.first.country!;
      }).catchError((e) {
        emit(MyCountryErrorState("Failed to get country by location"));
        return;
      });
    }

    return await _getCountryByName(country);
  }

  Future<Country?> _getCountryByName(String countryName) async {
    try {
      var response = await Dio().get(
          "https://restcountries.com/v3.1/alpha/${countryName.toLowerCase()}");
      if (response.statusCode == 200) {
        return Country.fromJson(response.data[0]);
      }
    } catch (e) {
      emit(MyCountryErrorState("Failed to get country by name"));
    }
    return null;
  }

  @override
  void onChange(Change<MyCountryState> change) {
    super.onChange(change);
    // print(state.toString());
  }
}
