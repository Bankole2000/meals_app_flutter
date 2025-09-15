import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final finteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: finteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Pick your category')),
    //   body:
    return GridView(
      padding: const EdgeInsets.all(16),
      // we could use GridView.builder for longer lists
      // for a grid with fixed number of columns (crossAxisCount i.e. left to right)
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20, // horizontal spacing
        mainAxisSpacing: 20, // vertical spacing
      ),
      children: [
        // we could use a for loop here too
        // for (final category in availableCategories)
        //   CategoryGridItem(category: category),
        ...availableCategories.map(
          (category) => CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
        ),
      ],
    );
    // );
  }
}
