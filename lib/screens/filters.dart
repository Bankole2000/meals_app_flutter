import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart';

// enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

// class FiltersScreen extends ConsumerStatefulWidget {
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key /* required this.currentFilters */});

  // final Map<Filter, bool> currentFilters; // inherited state

  //   @override
  //   ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
  // }

  // class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  //   var _glutenFreeFilterSet = false;
  //   var _lactoseFreeFilterSet = false;
  //   var _veganFilterSet = false;
  //   var _vegetarianFilterSet = false;

  //   @override
  //   void initState() {
  //     super.initState();
  //     // Get filters from provider
  //     final activeFilters = ref.read(filtersProvider);
  //   //  Setting local state with inherited State
  //     // _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
  //     // _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  //     // _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  //     // _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;

  //   // Updating Local State with provider State
  //     // _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  //     // _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  //     // _veganFilterSet = activeFilters[Filter.vegan]!;
  //     // _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
  //   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      // if you want this page to have navigation drawer too
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(
      //         context,
      //       ).push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
      //     }
      //   },
      // ),
      appBar: AppBar(title: const Text('Your Filters')),
      body:
          // PopScope(
          //   canPop: false,
          //   onPopInvokedWithResult: (bool didPop, dynamic result) async {
          //     // if (didPop) return;
          //     ref.read(filtersProvider.notifier).setFilters({
          //       Filter.glutenFree: _glutenFreeFilterSet,
          //       Filter.lactoseFree: _lactoseFreeFilterSet,
          //       Filter.vegetarian: _vegetarianFilterSet,
          //       Filter.vegan: _veganFilterSet,
          //     });
          //     // These variables will then be accessible when the filter screen is popped
          //     // Navigator.of(context).pop({
          //     //   Filter.glutenFree: _glutenFreeFilterSet,
          //     //   Filter.lactoseFree: _lactoseFreeFilterSet,
          //     //   Filter.vegetarian: _vegetarianFilterSet,
          //     //   Filter.vegan: _veganFilterSet,
          //     // });
          //   },
          //   child:
          Column(
            children: [
              SwitchListTile(
                // value: _glutenFreeFilterSet,
                value: activeFilters[Filter.glutenFree]!,
                onChanged: (isChecked) {
                  // setState(() {
                  //   _glutenFreeFilterSet = isChecked;
                  // });
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(Filter.glutenFree, isChecked);
                },
                title: Text(
                  'Gluten-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  'Only include gluten-free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                // value: _lactoseFreeFilterSet,
                // onChanged: (isChecked) {
                //   setState(() {
                //     _lactoseFreeFilterSet = isChecked;
                //   });
                // },
                value: activeFilters[Filter.lactoseFree]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(Filter.lactoseFree, isChecked);
                },
                title: Text(
                  'Lactose-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  'Only include lactose-free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                // value: _vegetarianFilterSet,
                // onChanged: (isChecked) {
                //   setState(() {
                //     _vegetarianFilterSet = isChecked;
                //   });
                // },
                value: activeFilters[Filter.vegetarian]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(Filter.vegetarian, isChecked);
                },
                title: Text(
                  'Vegetarian',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  'Only include vegetarian meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                // value: _veganFilterSet,
                // onChanged: (isChecked) {
                //   setState(() {
                //     _veganFilterSet = isChecked;
                //   });
                // },
                value: activeFilters[Filter.vegan]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(Filter.vegan, isChecked);
                },
                title: Text(
                  'Vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  'Only include vegan meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                activeThumbColor: Theme.of(context).colorScheme.primary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
            ],
          ),
      // ),
    );
  }
}
