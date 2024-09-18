import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/favorites_provider.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(movie);

    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: Image.network(
        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        onPressed: () {
          favoritesProvider.toggleFavorite(movie);
        },
      ),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: movie);
      },
    );
  }
}
