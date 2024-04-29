import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_details.dart';
import 'package:meals_app/widgets/meal_image_card.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meal,
    // required this.category,
  });
  //making the title optional
  final String? title;
  // final Category category;
  final List<Meal> meal;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealDetails(
                  meal,
                )));
  }

  @override
  Widget build(BuildContext context) {
//if there are meals in the category, we will display them
    Widget content = ListView.builder(
      itemCount: meal.length,
      itemBuilder: (context, index) {
        return MealImageCard(
          meal[index],
          onSelectMeal: selectMeal,
        );
      },
    );
    //if there are no meals in the category, we will display a message
    if (meal.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text('Uh oh...nothing here yet!',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            const SizedBox(height: 16),
            Text(
              'Try Selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    }
    //if the title is null, we will return the content
    //this is for the case where we are not viewing a category i.e tab bar favorites scrren
    if (title == null) {
      return content;
    }

    //if the title is not null, we will return a scaffold with the content
    //this is for when we are viewing a category
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
