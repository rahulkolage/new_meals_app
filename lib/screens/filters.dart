import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:new_meals_app/screens/tabs.dart';
// import 'package:new_meals_app/widgets/main_drawer.dart';

import 'package:new_meals_app/providers/filters_provider.dart';

// moved to filters provider
// enum Filter {
//   glutenFree,
//   lactoseFree,
//   vegetarian,
//   vegan,
// }

// class FilterScreen extends ConsumerStatefulWidget {
class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  // final Map<Filter, bool> currentFilters;

//   @override
//   ConsumerState<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends ConsumerState<FilterScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFilterSet = false;
//   var _veganFilterSet = false;

//   // simplifying state logic by only using provider
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   final activeFilters = ref.read(filtersProvider);

//   //   // _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
//   //   // _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
//   //   // _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
//   //   // _veganFilterSet = widget.currentFilters[Filter.vegan]!;

//   //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
//   //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
//   //   _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
//   //   _veganFilterSet = activeFilters[Filter.vegan]!;
//   // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      // drawer: MainDrawer(onSelectedScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body:
          // // commenting WillPopScope to manage state via provider by outsourcing state
          // WillPopScope(
          //   onWillPop: () async {
          //     ref.read(filtersProvider.notifier).setFilters({
          //       Filter.glutenFree: _glutenFreeFilterSet,
          //       Filter.lactoseFree: _lactoseFreeFilterSet,
          //       Filter.vegetarian: _vegetarianFilterSet,
          //       Filter.vegan: _veganFilterSet,
          //     });
          //     return true;
          //     // pop allows us to send some data, which will available
          //     // where we navigated to i.e. tabs.dart screen
          //     // Navigator.of(context).pop({
          //     //   Filter.glutenFree: _glutenFreeFilterSet,
          //     //   Filter.lactoseFree: _lactoseFreeFilterSet,
          //     //   Filter.vegetarian: _vegetarianFilterSet,
          //     //   Filter.vegan: _veganFilterSet,
          //     // });
          //     // return false;
          //   },
          //   child:
          Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter
                .glutenFree]!, //_glutenFreeFilterSet,  // local state is no longer available, we have to use provider via ref
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
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!, // _lactoseFreeFilterSet,
            onChanged: (isChecked) {
              // setState(() {
              //   _lactoseFreeFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!, //_vegetarianFilterSet,
            onChanged: (isChecked) {
              // setState(() {
              //   _vegetarianFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!, // _veganFilterSet,
            onChanged: (isChecked) {
              // setState(() {
              //   _veganFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
      // ),
    );
  }
}
