import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../widgets/movie_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                favoritesProvider.updateQuery(value);
                favoritesProvider.searchMovies(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search for a movie...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          favoritesProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: favoritesProvider.searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = favoritesProvider.searchResults[index];
                      return MovieTile(movie: movie);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
