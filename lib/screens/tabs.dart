import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:new_meals_app/data/dummy_data.dart'; // commented for using Riverpod Provider
// import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/screens/categories.dart';
// import 'package:new_meals_app/screens/filters.dart'; // commented above for using GoRouter
import 'package:new_meals_app/screens/meals.dart';
import 'package:new_meals_app/widgets/main_drawer.dart';
// import 'package:new_meals_app/providers/meals_provider.dart';
import 'package:new_meals_app/providers/favorites_provider.dart';
import 'package:new_meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// class TabsScreen extends StatefulWidget {
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final bool isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('Meal no longer a favorite.');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Marked as a favorite.');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    // first close drawer if open
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      // // we will continue to use push as we want back button on
      // // fitlers screen to work
      // // final result =
      // await Navigator.of(context).push<Map<Filter, bool>>(
      //   MaterialPageRoute(
      //     builder: (ctx) => const FilterScreen(),
      //     // currentFilters: _selectedFilters, // no more needed as we are using Filters provider
      //   ),
      // );

      // commented above for using GoRouter
      // GoRouter.of(context).push<Map<Filter, bool>>('/FilterScreen');
      context.go('/filters');

      // no longer needed as this is done via Provider
      // setState(() {
      //   // result can NULL, so we neee to provide fallback value
      //   // we will declare global variable of type Filter
      //   _selectedFilters = result ?? kInitialFilters;
      // });

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (ctx) => const FilterScreen(),
      //   ),
      // );
    }
    // else {
    //   // open meals screen, i.e. tabs screen
    //   // when click on meals, we might already on meals screen
    //   // so close drawer.
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // we will pass filtered list based on filters to categories screen
    // instead filtering items inside category screen
    // final availableMeals = dummyMeals.where((meal) {

    // we will use Provider to get dummyMeals
    // ref property of riverpod to setup Listeners for providers.

    // // Connecting Multiple Providers with each other
    // // moving code below to filters provider

    // final meals = ref.watch(mealsProvider);
    // final activeFilters = ref.read(filtersProvider);

    final availableMeals = ref.watch(filteredMealsProvider);

    // meals.where((meal) {
    //   // if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //   if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }

    //   return true;
    // }).toList();

    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // setState(() {
      //   // Favorites
      //   activePage = MealsScreen(
      //     meals: _favoriteMeals,
      //     onToggleFavorite: _toggleMealFavoriteStatus,
      //   );
      //   activePageTitle = 'Your Favorites';
      // });

      final favoriteMeals = ref.watch(favoriteMealsProvider);
      // Favorites
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
