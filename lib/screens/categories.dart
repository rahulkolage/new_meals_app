import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_meals_app/data/dummy_data.dart';
import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/models/category.dart';
// import 'package:new_meals_app/screens/meals.dart';
import 'package:new_meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    // required this.onToggleFavorite,
    required this.availableMeals,
  });

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    var filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // commented above for using GoRouter
    // // Navigator.of(context).push(route); // alternate syntax
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (ctx) {
    //     return MealsScreen(
    //       title: category.title,
    //       meals: filteredMeals,
    //       // onToggleFavorite: onToggleFavorite,
    //     );
    //   },
    // ));

    // GoRouter.of(context).go('/MealsScreen/${category.title}', extra: filteredMeals);

    GoRouter.of(context).go('/meals', extra: {'title':category.title, 'meals': filteredMeals});
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
