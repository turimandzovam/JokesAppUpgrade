import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String type;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const JokeCard({super.key, required this.type, required this.onTap, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(type, style: const TextStyle(fontSize: 18)),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border), // Икона за омилени
          onPressed: onFavorite, // Акција при клик на иконата
        ),
        onTap: onTap,
      ),
    );
  }
}
