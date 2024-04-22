import '/models/category.dart';
import 'package:flutter/material.dart';

// for each category, we will create a grid item
class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function(BuildContext context, Category category) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    //inkwell is a material widget that makes its child interactive i.e clickable/tapppable with a ripple effect
    return InkWell(
      onTap: () {
        onSelectCategory(context, category);
      },
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  category.color.withOpacity(0.57),
                  category.color.withOpacity(0.9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Center(
            child: Text(category.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      //changing the color of the text
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
          )),
    );
  }
}
