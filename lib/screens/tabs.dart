import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

// For stateless widget we use ConsumerWidget
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  // Map<Filter, bool> _selectedFilters = kInitialFilters;
  String activePageTitle = 'Categories';
  // final List<Meal> _favoriteMeals = [];

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text(message)));
  // }

  // void _toggleFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   setState(() {
  //     if (isExisting) {
  //       setState(() {
  //         _favoriteMeals.remove(meal);
  //       });
  //       _showInfoMessage('Meal removed from favorites.');
  //     } else {
  //       setState(() {
  //         _favoriteMeals.add(meal);
  //       });
  //       _showInfoMessage('Meal added to favorites.');
  //     }
  //   });
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // final result =
      await Navigator.of(
        context,
        // You can also use pushReplacement which leaves no history (i.e. you can't use back)
        // but then you can't get any result back
        // push also returns a Future which completes when the new screen is popped
      ).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            // currentFilters: _selectedFilters
          ),
        ),
      );
      // this returns the filters sent from the filters screen
      // print(result);
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    } else if (identifier == 'meals') {
      _selectPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // use ref.watch(provider) for providers that change often to rebuild
    // user ref.read() for providers that don't change often to read once
    // final meals = ref.watch(mealsProvider);
    // final activeFilters = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filteredMealsProvider);
    // meals.where((meal) {
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
    // if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //   return false;
    // }
    // if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //   return false;
    // }
    // if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //   return false;
    // }
    // if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
    //   return false;
    // }
    //   return true;
    // }).toList();

    Widget activePage = CategoriesScreen(
      // onToggleFavoriteStatus: _toggleFavoriteStatus,
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
