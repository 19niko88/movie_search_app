import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/favorites_provider.dart';
import 'screens/movie_details_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Search App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SearchScreen(),
        routes: {
          '/details': (context) => const MovieDetailsScreen(),
        },
      ),
    );
  }
}
