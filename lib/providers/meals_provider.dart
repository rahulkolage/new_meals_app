import 'package:new_meals_app/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals; // providing dummymeals via Riverpod is not required as it's very basic data which can be imported directly.
});


// This basic provider is useful for static dummy data that never changes