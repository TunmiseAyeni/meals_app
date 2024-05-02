import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';

//to use animations, it needs to be in a stateful widget because we need to use the animationController
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

//SIngleTickerProviderStateMixin is a mixin that allows us to use the vsync property of the animation controller
//it is important to use the mixin when working with animations
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
//Explicit Animation
//adding an animationController

//late keyword is used to tell dart that the variable will be initialized later but not now
//we cannot initialize animationController heere because we cannot initialize in the state class  without the initState method because the context is not available yet
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    //initializing the animationController variable to the animationController class
    animationController = AnimationController(
      //vsync is used to synchronize the animation with the screen refresh rate to ensure that the animation is smooth, typically 60 frames per second
      //this represents the screen/class that we are animating on
      vsync: this,
      duration: const Duration(milliseconds: 300),
      //with animations,we animate between two values, the lowerBound and the upperBound in this case, 0 and 1
      //lowerBound and upperBound are the values that the animation will animate between,
      lowerBound: 0,
      upperBound: 1,
    );
    //starting the animation
    //forward() is used to start the animation from the lowerBound to the upperBound, repeat() is used to repeat the animation and stop() is used to stop the animation
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void selectCategory(BuildContext context, Category category) {
    //filtering the meals based on the category
//where meal is the current meal in the list
//basically, we are filtering the meals based on the category id, so  if the category id is equal to the id of the category we are currently viewing, we will add that meal to the list
//it will group all the meals that belong to the category we are currently viewing and add them to the list
////it will group all the meals that have the same category id as the category we are currently viewing and add them to the list
    ///
// now, we use the available meals to filter instead of dummy meals
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealsScreen(
                  title: category.title,
                  meal: filteredMeals,
                )));
  }

  @override
  Widget build(BuildContext context) {
    //AnimatedBuilder allows us to rebuild the widget tree when the animation changes, it helps to listen and then update the parts of the UI
    return AnimatedBuilder(
        animation: animationController,
        //this child widget is to set the widget that should be part of the animated content but not be animated themselves
        //the child widget is set to a widget that doesnt need to be unneccessary rebuilt or animated
        child: GridView(
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
        ),
        //The padding widget is the widget that would now be animated, the child is then set to the child(Gridview), meaning it would be displayed as content inside the padding widget but it would not be animated or reevaluated or rebuilt
        //setting the padding dynamically to the current cvalue of the upper and lowerbounds
        //animationController.value gives access to the current value of the bounds multiplied by 100

// Padding(
//               padding:
//                   //starting from 100 to 0
//                   EdgeInsets.only(top: 100 - animationController.value * 100),
//               child: child,
//             )

//another way to animate the padding is to use the SlideTransition widget
//the SlideTransition widget is used to animate the position of a widget, the child widget is the widget that we want to animate, which is the gridview in this case

// In the context of Flutter and UI development, an "animation offset" typically refers to the use of an Offset object to specify the amount of positional change in the animation of a widget. This is particularly useful for animations that involve moving or sliding widgets from one position to another on the screen.

// In Flutter, the AnimationController.drive() method is used to create a new animation derived from another animation. It essentially takes an existing animation controller and "drives" another animation property or value using it. This can be particularly useful when you want to apply a transformation, like a Tween, to the values generated by an AnimationController.
//it can be used to build an animation based on another animation

//Tween is used to animate the transition between two values, in this case, we are animating the position of the gridview
        builder: (context, child) => SlideTransition(
              // position: animationController.drive(Tween(
              //   begin: const Offset(0, 0.4),
              //   end: const Offset(0, 0),
              // or
              position: Tween(
                //controls the x and y position of the widget
                begin: const Offset(0, 0.4),
                end: const Offset(0, 0),
                //curveanimation is used to specify what type of animation we want to use, in this case, we are using the Curves.easeInOut animation
              ).animate(CurvedAnimation(
                  parent: animationController, curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
