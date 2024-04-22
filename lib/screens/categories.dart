import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void selectCategory(BuildContext context, Category category) {
    //filtering the meals based on the category
//where meal is the current meal in the list
//basically, we are filtering the meals based on the category id, so  if the category id is equal to the id of the category we are currently viewing, we will add that meal to the list
//it will group all the meals that belong to the category we are currently viewing and add them to the list
////it will group all the meals that have the same category id as the category we are currently viewing and add them to the list
    ///
// now, we use the available meals to filter instead of dummy meals
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealsScreen(
                  title: category.title,
                  meal: filteredMeals,
                  onToggleFavorite: onToggleFavorite,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      //the gridDelegate is a delegate that controls the layout of the children within the [GridView}
      //SliverGridDelegateWithFixedCrossAxisCount is a delegate that creates a grid with a fixed number of tiles in the cross axis.
      //childAspectRatio is the ratio of the cross-axis to the main-axis extent of each child.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        //or
        //avsailableCategories.map((category) => CategoryGridItem(category: category)).toList(),`
        for (final category in availableCategories)
          CategoryGridItem(
              category: category, onSelectCategory: selectCategory),
      ],
    );
  }
}
