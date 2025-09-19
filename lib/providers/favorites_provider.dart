import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends Notifier<List<Meal>> {
  // Initial state
  @override
  List<Meal> build() {
    return [];
  }

  // Methods / Functions that mutate state here
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; // meal has been removed from (i.e. is not among) favorites
    } else {
      state = [...state, meal];
      return true; // meal has been added to (i.e. is now among) favorites
    }
  }

  bool mealIsFavorite(Meal meal) => state.contains(meal);
}

final favoriteMealsProvider =
    NotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      FavoriteMealsNotifier.new,
    );
