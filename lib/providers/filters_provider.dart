import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum FilterOptions { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  //iniyializing the filters with the initial values
  FiltersNotifier()
      : super({
          FilterOptions.glutenFree: false,
          FilterOptions.lactoseFree: false,
          FilterOptions.vegetarian: false,
          FilterOptions.vegan: false,
        });

//setting the filters based on the filters that the user has selected
  void setFilters(Map<FilterOptions, bool> filters) {
    state = filters;
  }

//setting the filters based on the filter that was selected and if the filter is active
  void setFilter(FilterOptions filter, bool isActive) {
    // state[filter] = isActive; we cannot directly modify the state, so we have to create a new map and replace the old one
    state = {
      //seting state to a new map and replacing the old one, we are copying the old map and replacing the value of the filter that was selected with the new value
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>((ref) {
  return FiltersNotifier();
});

//we are using just the provider class and not statenotifierprovuder because we are not changing the state of the meals, we are just filtering the meals based on the filters that the user has selected
final filteredMealsProvider = Provider((ref) {
  //provider depending on anorher provider
  //we are using the ref to watch the meals provider and the filters provider so that the filtered meals provider will be updated whenever the meals provider or the filters provider changes
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where(
    (meal) {
      //checking if the meal is lactose free and the lactose free filter is selected, if it is not, we will return false
      if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }
      //if the meal passes all the checks, we will return true
      return true;
    },
  ).toList();
});
