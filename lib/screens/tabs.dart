import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> favoriteMeals = [];
  int selectedPageIndex = 0;
  // storing the selected filters in a map
  Map<FilterOptions, bool> selectedFilters = kInitialFilters;

//showing messages when
  void showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 4),
    ));
  }

  void toggleFavoriteMeal(Meal meal) {
    //checking if the meal is already in the list of favorite meals
    final isExisting = favoriteMeals.contains(meal);
    setState(() {
      //if the meal is already in the list, we will remove it
      if (isExisting) {
        favoriteMeals.remove(meal);
        showMessage('Meal removed as favorite');
        //if the meal is not in the list, we will add it
      } else {
        favoriteMeals.add(meal);
        showMessage('Meal marked as favorite!');
      }
    });
  }

  void selectPage(int index) {
    setState(() {
      //setting the selectedPageIndex to the index of the tab that was clicked
      selectedPageIndex = index;
    });
  }

//receiving the value that was passed from the filters screen
  void setScreen(String identifier) async {
    //if the identifier is not filters i.e its already on the tabsScreen, we will pop the current screen
    Navigator.pop(context);
    if (identifier == 'filters') {
      //waiting for the use rto press the back button so that the values can be passed to the tabsScreen and then we can use the values abd store them in the result variable. Push is a generic type,m meaning that we can specify the type of data that we want to receive from the screen that we are pushing to in this case, the map takes in the filter options and a boolean value
      final result = await Navigator.push<Map<FilterOptions, bool>>(
          context,
          MaterialPageRoute(
              builder: (context) => FiltersScreen(
                    currentFilters: selectedFilters,
                  )));

//updating the selected filters based on the result
      setState(() {
        //if the result is null, we will set the selected filters to the initial filters
        //?? checks if the value is null, if it is null, it will use the value after the ??
        selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
// filtering the meals based on the selected filters and storing them in the availableMeals variable, then passing the it to the categories screen
    final availableMeals = dummyMeals.where(
      (meal) {
        //checking if the meal is lactose free and the lactose free filter is selected, if it is not, we will return false
        if (selectedFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (selectedFilters[FilterOptions.lactoseFree]! &&
            !meal.isLactoseFree) {
          return false;
        }
        if (selectedFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (selectedFilters[FilterOptions.vegan]! && !meal.isVegan) {
          return false;
        }
        //if the meal passes all the checks, we will return true
        return true;
      },
    ).toList();

    //setting the active screen based on the selectedPageIndex
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
      onToggleFavorite: toggleFavoriteMeal,
    );
    var activePageTitle = 'Categories';
    if (selectedPageIndex == 1) {
      activeScreen = MealsScreen(
          title: 'Favourites',
          meal: favoriteMeals,
          onToggleFavorite: toggleFavoriteMeal);
      activePageTitle = 'Your favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      //the drawer widget
      drawer: MainDrawer(
        onSelectScreen: setScreen,
      ),
      body: activeScreen,
      //for creating a bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        //ontap takes in a function that takes in an integer parameter
        onTap: selectPage,
        //items is a list of tabs basically
        //current index is the index of the tab that is currently selected
        //helps to highlight the tab that is currently selected
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites')
        ],
      ),
    );
  }
}
