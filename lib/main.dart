import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/routes/app_route_config.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   theme: theme,
    //   home: const TabsScreen(),
    // );

    // using GoRouter
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Meals App',
      routerConfig: AppRouteConfig().router,
    );
  }
}
