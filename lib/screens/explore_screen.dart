
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/favorites_store.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'Tout';

  final List<String> categories = [
    'Tout',
    'Plages',
    'Nature',
    'Culture',
    'Restaurants',
  ];

  final List<Map<String, dynamic>> places = [
    {
      'name': 'Île de Gorée',
      'location': 'Dakar, Sénégal',
      'category': 'Culture',
      'image':
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
      'description': 'Une île pleine d’histoire et de charme.',
    },
    {
      'name': 'Lac Rose',
      'location': 'Rufisque, Sénégal',
      'category': 'Nature',
      'image':
          'https://images.unsplash.com/photo-1470770841072-f978cf4d019e',
      'description': 'Un paysage naturel unique à découvrir.',
    },
    {
      'name': 'Saly',
      'location': 'Mbour, Sénégal',
      'category': 'Plages',
      'image':
          'https://images.unsplash.com/photo-1518837695005-2083093ee35b',
      'description': 'Profitez du soleil et de l’océan.',
    },
    {
      'name': 'Cap Skirring',
      'location': 'Casamance, Sénégal',
      'category': 'Plages',
      'image':
          'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
      'description': 'Une escapade entre plage et nature.',
    },
  ];


  List<Map<String, dynamic>> get filteredPlaces {
    final query = searchController.text.toLowerCase();

    return places.where((place) {
      final matchesCategory = selectedCategory == 'Tout' ||
          place['category'] == selectedCategory;

      final matchesSearch =
          place['name'].toString().toLowerCase().contains(query) ||
          place['location'].toString().toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredPlaces;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LUMORA / DÉCOUVERTE',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Explorez\\nle Sénégal.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 12),

              const Text(
                'Des endroits uniques, des souvenirs inoubliables.',
                style: TextStyle(
                  color: AppTheme.muted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 25),

              // Recherche
              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Rechercher un lieu...',
                  hintStyle: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppTheme.primary,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Catégories
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 9),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final selected = selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppTheme.dark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : AppTheme.muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lieux à découvrir',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '${results.length} lieux',
                    style: const TextStyle(
                      color: AppTheme.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Liste des destinations
              if (results.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Aucun lieu trouvé.',
                      style: TextStyle(
                        color: AppTheme.muted,
                      ),
                    ),
                  ),
                ),

              ...results.map((place) {
                final name = place['name'] as String;
                final isFavorite = FavoritesStore.contains(name);

                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(23),
                            ),
                            child: Image.network(
                              place['image'],
                              height: 190,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  height: 190,
                                  color: AppTheme.background,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 40,
                                      color: AppTheme.muted,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Positioned(
                            top: 14,
                            right: 14,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                    FavoritesStore.toggle(place);
                                });
                              },
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 14,
                            left: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                place['category'],
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.dark,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 15,
                                  color: AppTheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  place['location'],
                                  style: const TextStyle(
                                    color: AppTheme.muted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Text(
                              place['description'],
                              style: const TextStyle(
                                color: AppTheme.muted,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
