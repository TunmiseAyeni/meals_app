import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

enum FilterOptions { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

// the map of the filters that the user has selected, we want to pass it to the tabs screen when the user pops the screen
  final Map<FilterOptions, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isGlutenFree = false;
  var isLactoseFree = false;
  var isVegetarianFree = false;
  var isVeganFree = false;
//to save the filters that the user has selected and not lose them when the screen is popped

// overriding the initial values with the initial values that were passed to the screen with the init state method
  @override
  void initState() {
    super.initState();
    isGlutenFree = widget.currentFilters[FilterOptions.glutenFree]!;
    isLactoseFree = widget.currentFilters[FilterOptions.lactoseFree]!;
    isVegetarianFree = widget.currentFilters[FilterOptions.vegetarian]!;
    isVeganFree = widget.currentFilters[FilterOptions.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
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
      body: PopScope(
        //canPop is used to determine if the current route can be popped with the back button
        //can pop is set to false so that the back button will not pop the current screen because we already have our own back button logic
        canPop: false,
        //onPopInvoked is a callback that is called when the back button is pressed
        onPopInvoked: ((didPop) {
          //if the back button was already pressed, we will return and not do anything
          if (didPop) {
            return;
          } else {
            //if the back button was not pressed, we will pop the current screen and pass a map of the filters to the previous screen
            //we are passing a map of the filters to the previous screen which is the tabsScreen
            Navigator.pop(context, {
              FilterOptions.glutenFree: isGlutenFree,
              FilterOptions.lactoseFree: isLactoseFree,
              FilterOptions.vegetarian: isVegetarianFree,
              FilterOptions.vegan: isVeganFree,
            });
          }
        }),
        child: Column(
          //swtchListTile allows us to create a switch in a list tile or row
          children: [
            SwitchListTile(
              value: isGlutenFree,
              //setting the value of the switch to the value of isGlutenFree
              onChanged: (newValue) {
                setState(() {
                  isGlutenFree = newValue;
                });
              },
              title: Text('Gluten-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              subtitle: Text(
                'Only include gluten-free meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              //contols the color of the switch when it is active
              activeColor: Theme.of(context).colorScheme.tertiary,
              //content padding is used to add padding to the content of the list tile
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: isLactoseFree,
              //setting the value of the switch to the value of isGlutenFree
              onChanged: (newValue) {
                setState(() {
                  isLactoseFree = newValue;
                });
              },
              title: Text('Lactose-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              subtitle: Text(
                'Only include lactose-free meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              //contols the color of the switch when it is active
              activeColor: Theme.of(context).colorScheme.tertiary,
              //content padding is used to add padding to the content of the list tile
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: isVegetarianFree,
              //setting the value of the switch to the value of isGlutenFree
              onChanged: (newValue) {
                setState(() {
                  isVegetarianFree = newValue;
                });
              },
              title: Text('Vegetarian-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              subtitle: Text(
                'Only include vegetarian-free meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              //contols the color of the switch when it is active
              activeColor: Theme.of(context).colorScheme.tertiary,
              //content padding is used to add padding to the content of the list tile
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: isVeganFree,
              //setting the value of the switch to the value of isGlutenFree
              onChanged: (newValue) {
                setState(() {
                  isVeganFree = newValue;
                });
              },
              title: Text('Vegan-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              subtitle: Text(
                'Only include vegan-free meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              //contols the color of the switch when it is active
              activeColor: Theme.of(context).colorScheme.tertiary,
              //content padding is used to add padding to the content of the list tile
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
