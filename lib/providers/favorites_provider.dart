import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

//the stateNotifierProvider works together with the StateNotifier class
//we are telling riverpod the type of data that will be managed by the notifier
class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  //we pass the initial data to super, which is an empty list
  FavoritesMealsNotifier() : super([]);

  bool onToggleMealFavorite(Meal meal) {
    //stateNotifier class doesnt allow us to directly modify the state, so we use the state property to get the current state and modify it, we cannot edit an existing value in memory, instead we must create a new one and replace the old one

    //the state property holds our data (List<Meal>) and we can modify it by creating a new list and replacing the old one
    //we are checking if the meal is already in the list of favorite meals
    final mealsFavorite = state.contains(meal);
    if (mealsFavorite) {
      //if the meal is already in the list, we will remove it, but we cannot use remove method because of riverpod, so we use the where method to filter out the meal we want to remove, it will return a new list of meals that we want to keep
      state = state.where((meals) => meals.id != meal.id).toList();
      return false;
    } else {
      //if the meal is not in the list, we will add it
      //using the spread operator to copy the current state and add the new meal to the list
      //the spread operator removes individual items from the list and adds them to the new list
      state = [...state, meal];
      return true;
    }
  }
}

//stateNotifierProvider class is optimized for dynamic data that changes over time
//we return the instance of the FavoritesMealsNotifier class to the provider
//we also have to pass the type of data that the provider will manage
final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>(
        (ref) => FavoritesMealsNotifier());

//N.B we have to pass the type of data that the provider will manage to the StateNotifierProvider class and we also have to pass the type of data that will be managed by the StateNotifier class as well 
