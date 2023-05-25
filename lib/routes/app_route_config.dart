import 'package:go_router/go_router.dart';
import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/screens/tabs.dart';
import 'package:new_meals_app/screens/filters.dart';
import 'package:new_meals_app/screens/meals.dart';

class AppRouteConfig {
  final router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const TabsScreen(),
        routes: [
          GoRoute(
            name: 'filters',
            path: 'filters',
            builder: (context, state) => const FilterScreen(),
          ),
          GoRoute(
            path: 'meals',
            builder: (context, state) {
              final extraMap = state.extra as Map<String, dynamic>;
              final title = extraMap['title'] as String?;
              final meals = extraMap['meals'] as List<Meal>;
              return MealsScreen(
                title: title, // state.pathParameters['title'],
                meals: meals,
              );
            },
          ),
        ],
      ),
    ],
    // debugLogDiagnostics: true,
  );
}
