import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PairsContainer extends StatelessWidget {
  const PairsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Import the PlayerProvider to access the list of players
    final playerProvider = context.watch<PlayerProvider>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: 300, // Adjust height as needed
      width: double.infinity, // Full width of the parent
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jugadores',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: playerProvider.players.length,
              itemBuilder: (context, index) {
                final player = playerProvider.players[index];
                return ListTile(
                  title: Text(player.name),
                  subtitle: Text('Regalo para: ${player.gifts.join(', ')}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
