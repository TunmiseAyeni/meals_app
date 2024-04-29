import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

// the map of the filters that the user has selected, we want to pass it to the tabs screen when the user pops the screen

//managing all the locaL states in the provider and not in the screen
  // var isGlutenFree = false;
  // var isLactoseFree = false;
  // var isVegetarianFree = false;
  // var isVeganFree = false;
//to save the filters that the user has selected and not lose them when the screen is popped

// overriding the initial values with the initial values that were passed to the screen with the init state method
  // @override
  // void initState() {
  //   //used ref.read baecause the initState runs once and so  no need to listen to changes in the provider
  //   final activeFilter = ref.read(filtersProvider);
  // //   super.initState();
  // //   isGlutenFree = activeFilter[FilterOptions.glutenFree]!;
  // //   isLactoseFree = activeFilter[FilterOptions.lactoseFree]!;
  // //   isVegetarianFree = activeFilter[FilterOptions.vegetarian]!;
  // //   isVeganFree = activeFilter[FilterOptions.vegan]!;
  // // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.pop(context);
      //     if (identifier == 'meals') {
      //       //instead of pusing push and just pushing the screens, we can use pushReplacement to replace the current screen with the new screen, therefore
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => const TabsScreen()));
      //     }
      //   },
      // ),
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      //popscope is used to add a listener to the back button so that we can listen to when the back button is pressed
      body:
          // PopScope(
          //   //canPop is used to determine if the current route can be popped with the back button
          //   //can pop is set to false so that the back button will not pop the current screen because we already have our own back button logic else it will pop the current screen
          //   canPop: true,
          //   //onPopInvoked is a callback that is called when the back button is pressed
          //   onPopInvoked: ((didPop) {
          //     //if the back button was already pressed, we will return and not do anything

          //     if (didPop) {
          //       return;
          //     } else {
          //       //updating the provider with the new values of the filters that the user has selected as the user leaves the screen
          //       //if the back button was not pressed, we will update the provider with the new values of the filters that the user has selected
          //       ref.read(filtersProvider.notifier).setFilters({
          //         FilterOptions.glutenFree: isGlutenFree,
          //         FilterOptions.lactoseFree: isLactoseFree,
          //         FilterOptions.vegetarian: isVegetarianFree,
          //         FilterOptions.vegan: isVeganFree,
          //       });

          //       //if the back button was not pressed, we will pop the current screen and pass a map of the filters to the previous screen
          //       //we are passing a map of the filters to the previous screen which is the tabsScreen
          //       // Navigator.pop(context, {
          //       //   FilterOptions.glutenFree: isGlutenFree,
          //       //   FilterOptions.lactoseFree: isLactoseFree,
          //       //   FilterOptions.vegetarian: isVegetarianFree,
          //       //   FilterOptions.vegan: isVeganFree,
          //       // });
          //     }
          //   }),
          //   child:
          Column(
        //swtchListTile allows us to create a switch in a list tile or row
        children: [
          SwitchListTile(
            value: activeFilters[FilterOptions.glutenFree]!,
            //setting the value of the switch to the value of isGlutenFree
            onChanged: (newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.glutenFree, newValue);
            },
            title: Text('Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //contols the color of the switch when it is active
            activeColor: Theme.of(context).colorScheme.tertiary,
            //content padding is used to add padding to the content of the list tile
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[FilterOptions.lactoseFree]!,
            //setting the value of the switch to the value of isGlutenFree
            onChanged: (newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.lactoseFree, newValue);
            },
            title: Text('Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text(
              'Only include lactose-free meals',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //contols the color of the switch when it is active
            activeColor: Theme.of(context).colorScheme.tertiary,
            //content padding is used to add padding to the content of the list tile
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[FilterOptions.vegetarian]!,
            //setting the value of the switch to the value of isGlutenFree
            onChanged: (newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegetarian, newValue);
            },
            title: Text('Vegetarian-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text(
              'Only include vegetarian-free meals',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //contols the color of the switch when it is active
            activeColor: Theme.of(context).colorScheme.tertiary,
            //content padding is used to add padding to the content of the list tile
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            //activeFilters[FilterOptions.vegan]! is used to get the value of the vegan filter from the activeFilters map
            value: activeFilters[FilterOptions.vegan]!,
            //setting the value of the switch to the value of isGlutenFree
            onChanged: (newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegan, newValue);
            },
            title: Text('Vegan-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text(
              'Only include vegan-free meals',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            //contols the color of the switch when it is active
            activeColor: Theme.of(context).colorScheme.tertiary,
            //content padding is used to add padding to the content of the list tile
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
