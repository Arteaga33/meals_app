import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screens.dart';
import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if((_filters['gluten'] ?? false) && !meal.isGlutenFree){
          return false;
        }
        if ((_filters['lactorse'] ?? false) && !meal.isLactoseFree){
          return false;
        }
        if ((_filters['vegan'] ?? false) && !meal.isVegan){
          return false;
        }
        if ((_filters['vegetarian'] ?? false) && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => mealId == meal.id);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)), 
              headline1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home:
      //     const CategoriesScreen(), //This always marks the entry point of app.
      initialRoute: '/',
      routes: {
        //This is useful for larger apps
        '/': ((context) => TabsScreen(_favoriteMeals)),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals), //This aproach is a bot more complex.
        MealDetailScreen.routeName:(context) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScereen.routeName: ((context) => FilterScereen(_filters, _setFilters))
      },
      // onGenerateRoute: (settings){//This exectues if the route is not in the routes tabla, like a default. Usually not needed.
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (context) => CategoriesScreen());
      // },
      onUnknownRoute: (settings){ //this executes if the page route is about to show an error shows this instead.
        return MaterialPageRoute(builder: ((context) => CategoriesScreen()));
      },
    );
  }
}
