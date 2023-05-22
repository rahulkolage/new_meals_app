import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // constructor with initializer list
  FavoriteMealsNotifier()
      : super([]); // call super to reach out ot parent class i.e. StateNotifier
  // to super we pass data same as of data type of StateNotifier

  bool toggleMealFavoriteStatus(Meal meal) {
    final isMealFavorite = state.contains(meal);

    if (isMealFavorite) {
      // remove meal
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // add meal
      state = [...state, meal]; // spread operator
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
