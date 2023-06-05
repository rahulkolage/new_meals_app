import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_meals_app/data/dummy_data.dart';
import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/models/category.dart';
// import 'package:new_meals_app/screens/meals.dart';
import 'package:new_meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    // required this.onToggleFavorite,
    required this.availableMeals,
  });

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),

      // by default lowerbound and upperbound are set to 0 and 1
      // lowerBound: 0,
      // upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    var filteredMeals = widget.availableMeals
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

    GoRouter.of(context)
        .go('/meals', extra: {'title': category.title, 'meals': filteredMeals});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      // above child is passed to builder
      // only padding will be animated 60 times per frame
      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(
      //     top: 100 - (_animationController.value * 100),
      //   ),
      //   child: child,
      // ),

      // animating using SlideTransition
      builder: (context, child) => SlideTransition(
        // position: _animationController.drive(
        //   Tween(
        //     begin: const Offset(0, 0.3), // 0.3 is 30% offset on y axis
        //     end: const Offset(0, 0),
        //   ).animate(parent),
        // ),

        // Since Tween return Animation object, same as .drive, we can replace
        // _animationController.drive with Tween
        position: Tween(
          begin: const Offset(0, 0.3), // 0.3 is 30% offset on y axis
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
