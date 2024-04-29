import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails(this.meal, {super.key});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //cchecking if the current meal is in the list of favorite meals,
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.star : Icons.star_outline),
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .onToggleMealFavorite(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(wasAdded
                    ? 'Added to favorites!'
                    : 'Removed from favorites!'),
                duration: const Duration(seconds: 4),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(meal.imageUrl,
                //boxfit.cover will make the image cover the entire container
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //.join() will join the elements of the list with a newline
            Center(
              child: Text(
                meal.ingredients.join('\n'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //.join() will join the elements of the list with a newline
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text(
                  meal.steps.join('\n\n'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
