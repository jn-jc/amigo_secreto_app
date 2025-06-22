import 'package:flutter/material.dart';

class PairsContainer extends StatelessWidget {
  const PairsContainer({super.key, required this.player1, required this.player2, required this.giftsForPlayer1, required this.giftsForPlayer2});
  final String player1;
  final String player2;
  final String giftsForPlayer1;
  final String giftsForPlayer2;

  @override
  Widget build(BuildContext context) {
    // Import the PlayerProvider to access the list of players
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8), // Use the primary color for the container background with a slight opacity
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.people, size: 30, color: Colors.black87),
                const SizedBox(width: 8.0),
                Text(
                  'Pareja:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '$player1 y $player2'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Regalos para $player1:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            Text(giftsForPlayer1.isNotEmpty ? giftsForPlayer1 : 'No hay regalos asignados'),
            const SizedBox(height: 16.0),
            Text(
              'Regalos para $player2:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            Text(giftsForPlayer2.isNotEmpty ? giftsForPlayer2 : 'No hay regalos asignados'),
          ],
        ),
      ),
    );
  }
}
