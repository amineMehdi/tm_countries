part of 'favourites_cubit.dart';

abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoadingState extends FavouritesState {}

class FavouritesLoadedState extends FavouritesState {
  final List<Country> countriesData;

  FavouritesLoadedState(this.countriesData);
}
