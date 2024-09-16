import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movie_provider.dart';
import '../services/api_service.dart';
import 'movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _searchMovies(String query) async {
    if (query.isEmpty) {
      Provider.of<MovieProvider>(context, listen: false).setMovies([]);
      return;
    }
    try {
      final apiService = ApiService();
      final result = await apiService.searchMovies(query);
      Provider.of<MovieProvider>(context, listen: false)
          .setMovies(result['results']);
    } catch (e) {
      // Handle errors (e.g., show a message to the user)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load movies')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchMovies,
              decoration: const InputDecoration(
                labelText: 'Search for a movie',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, provider, child) {
                if (provider.movies.isEmpty) {
                  return const Center(child: Text('No results found'));
                }
                return ListView.builder(
                  itemCount: provider.movies.length,
                  itemBuilder: (context, index) {
                    final movie = provider.movies[index];
                    final isFavorite = provider.isFavorite(movie['id']);
                    return ListTile(
                      leading: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                      title: Text(movie['title']),
                      subtitle: Text(movie['release_date'].substring(0, 4)),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          provider.toggleFavorite(movie['id']);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailsScreen(movie: movie),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
