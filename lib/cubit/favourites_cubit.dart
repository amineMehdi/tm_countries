import 'package:tm_countries/models/country.dart';
import 'package:bloc/bloc.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  void addToFavourites(Country country) {
    if (state is FavouritesLoadedState) {
      final FavouritesLoadedState currentState = state as FavouritesLoadedState;
      if (!currentState.countriesData.contains(country)) {
        currentState.countriesData.add(country);
        emit(FavouritesLoadedState(currentState.countriesData));
      }
    } else if (state is FavouritesInitial) {
      emit(FavouritesLoadedState([country]));
    }
  }

  void removeFromFavourites(Country country) {
    if (state is! FavouritesLoadedState) return;
    final FavouritesLoadedState currentState = state as FavouritesLoadedState;
    currentState.countriesData.remove(country);
    emit(FavouritesLoadedState(currentState.countriesData));
  }

  bool isFavourite(Country country) {
    if (state is! FavouritesLoadedState) return false;
    return (state as FavouritesLoadedState).countriesData.contains(country);
  }

  @override
  void onChange(Change<FavouritesState> change) {
    super.onChange(change);
    if (state is! FavouritesLoadedState) return;
    print("Favorites: ");
    for (Country c in (state as FavouritesLoadedState).countriesData) {
      print("${c.name.official} \n");
    }
  }
}
