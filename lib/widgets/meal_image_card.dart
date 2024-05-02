import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealImageCard extends StatelessWidget {
  const MealImageCard(
    this.meal, {
    super.key,
    required this.onSelectMeal,
  });
  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

//creating a getter for each enum
  String get complexityText {
    //splitting the enum value at the '.' and getting the last element
    //.name also helps convert to string
    //we also converted the first letter to uppercase
    final outputText = meal.complexity.name;
    final convertedText =
        '${outputText[0].toUpperCase()}${outputText.substring(1)}';
    return convertedText;
  }

  String get affordabilityText {
    //splitting the enum value at the '.' and getting the last element
    //.name also helps convert to string
    //we also converted the first letter to uppercase
    final outputText = meal.affordability.name.split('.').last;
    final convertedText =
        '${outputText[0].toUpperCase()}${outputText.substring(1)}';
    return convertedText;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onSelectMeal(context, meal);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        //by default, the stack widget ignores the shape of the card, so we need to wrap the card in a clipRRect widget to make the card  have rounded corners, the clipRrect widget clips any part of the child widget that goes beyond the rounded corners
        //clip.hardEdge clips the child widget to the rounded corners of the card
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //Hero widget is used to animate a widget from one screen to another, it is used to create a shared element transition between two screens
            Hero(
              //it must have a unique tag, then we go to the screen we want to animate to and give the same tag to the widget we want to animate
              tag: meal.id,
              //fade in widget allows you to have a placeholder image before the network image loads, and when the image is loaded, it fades in
              //fade in image is a widget that loads an image from the network and fades it in when it is loaded
              child: FadeInImage(
                  //putting the transparent image as a placeholder in the memoryImage widget
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity),
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black12.withOpacity(0.8),
                  Colors.black12.withOpacity(0.2),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            // Positioned widget is used to specufy the position of the child widget in a stack
            Positioned(
              // left: 0,
              // right: 0,
              bottom: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Text(
                      meal.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                      //maxLines is used to specify the maximum number of lines that the text can occupy
                      maxLines: 2,
                      //overflow is used to specify the text overflow if the text exceeds the maxLines
                      //ellipsis is used to show an ellipsis at the end of the text if it exceeds the maxLines ...
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(width: 10),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(width: 10),
                        MealItemTrait(
                            icon: Icons.attach_money, label: affordabilityText),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
