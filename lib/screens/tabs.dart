import 'package:flutter/material.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
};

//we replace stateful widget with consumerstateful widget because we are using riverpod
//consumerstateful widget is a widget that listens to changes in the provider and rebuilds the widget when the value of the provider changes
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

//we are adding functionality to the classes behind the scenes that allows us to reach out to the provider and listen to changes in the provider
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPageIndex = 0;
  // storing the selected filters in a map
  // Map<FilterOptions, bool> selectedFilters = kInitialFilters;

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
      await Navigator.push<Map<FilterOptions, bool>>(context,
          MaterialPageRoute(builder: (context) => const FiltersScreen()));

//updating the selected filters based on the result
      setState(() {
        //if the result is null, we will set the selected filters to the initial filters
        //?? checks if the value is null, if it is null, it will use the value after the ??
        // selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
// filtering the meals based on the selected filters and storing them in the availableMeals variable, then passing the it to the categories screen
//ref allows us to access the value of the provider, to set up listenrs to the provider
//ref.read allows us to get data from the provider once
//ref.watch sets up a listener to the provider, so that when the value of the provider changes, the widget will be rebuilt, that the build method executes again as our data changes
//basically, ref.watch executes the build method when the data in the meals provider is changed or updated
    // final meals = ref.watch(mealsProvider);
    // final activeFilters = ref.watch(filtersProvider);

    final availableMeals = ref.watch(filteredMealsProvider);

    //setting the active screen based on the selectedPageIndex
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        title: 'Favourites',
        meal: favoriteMeals,
      );
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
