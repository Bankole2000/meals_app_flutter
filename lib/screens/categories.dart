import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  // Animation needs some state to control the animation
  const CategoriesScreen({
    super.key,
    // required this.onToggleFavoriteStatus,
    required this.availableMeals,
  });

  // final void Function(Meal meal) onToggleFavoriteStatus;
  final List<Meal> availableMeals;

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoryScreenState();
}

// with keyword allows merging of other classes as mixins
// Single is for single animation controller
// for multiple animations use TickerProvider
class _CategoryScreenState extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late => does not have a value when created but will have an initial value when used
  late AnimationController _animationController;

  @override
  void initState() {
    // initialize the AnimationController in init state before the build is executed
    super.initState();

    _animationController = AnimationController(
      vsync: this, // references TickerProvider
      // vsync ticker ensures a smooth animation
      duration: Duration(milliseconds: 300),
      lowerBound: 0, // default
      upperBound:
          1, // default you can set to 20, point is animation feature range
      // bounds control between which values you animate
      // You translate the bounds to something that controls some property on the screen (e.g. margin etc)
    );

    // Different animation options => forward, repeat, reverse
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          // onToggleFavorite: onToggleFavoriteStatus,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Pick your category')),
    //   body:
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      // builder: (context, child) => Padding( // to animate a property
      // padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
      // Using Transition Widgets
      builder: (context, child) => SlideTransition(
        position: Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
        child: child,
      ),
    );
    // );
  }
}
