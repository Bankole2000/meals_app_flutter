import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealListItem extends StatelessWidget {
  const MealListItem({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(meal.title));
  }
}
