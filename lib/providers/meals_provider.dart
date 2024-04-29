//creating a simple provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

//instantiating the provider class
//provider class is optimized for static data that doesn't change over time
final mealsProvider = Provider(
  //provider class takes a function that takes ref as an argument
  (ref) {
    //returning the value that the provider will provide
    return dummyMeals;
  },
);
