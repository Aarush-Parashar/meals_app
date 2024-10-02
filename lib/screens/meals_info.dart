import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealsInfoScreen extends ConsumerWidget {
  const MealsInfoScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvieder);

    final bool isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvieder.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded ? 'Added as a favorite' : 'Removed from favorites',
                  ),
                ),
              );
            },
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 14),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 14),
          for (final ingredients in meal.ingredients)
            Text(
              ingredients,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          const SizedBox(height: 30),
          Text(
            'Reciepe',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 14),
          for (final steps in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: Text(
                steps,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
