
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/favorites_store.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: FavoritesStore.notifier,
          builder: (context, value, child) {
            final places = FavoritesStore.places;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LUMORA / COLLECTION',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Vos lieux\\nprécieux.',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Retrouvez les endroits que vous souhaitez découvrir.',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ma collection',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${places.length} lieux',
                        style: const TextStyle(
                          color: AppTheme.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  if (places.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 45,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              color: AppTheme.background,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.favorite_border_rounded,
                              size: 35,
                              color: AppTheme.primary,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            'Votre collection est vide',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Ajoutez vos lieux préférés depuis Explorer.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.muted,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ...places.map((place) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              place['image'],
                              width: 95,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  width: 95,
                                  height: 100,
                                  color: AppTheme.background,
                                  child: const Icon(
                                    Icons.image_outlined,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place['name'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                Text(
                                  place['location'],
                                  style: const TextStyle(
                                    color: AppTheme.muted,
                                    fontSize: 11,
                                  ),
                                ),

                                const SizedBox(height: 9),

                                Text(
                                  place['category'],
                                  style: const TextStyle(
                                    color: AppTheme.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              FavoritesStore.toggle(place);
                            },
                            icon: const Icon(
                              Icons.favorite_rounded,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
