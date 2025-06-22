import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/screens/pairs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PairsButton extends StatelessWidget {
  const PairsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerProvider playerProvider = context.watch<PlayerProvider>();

    createPairs() {
      if (playerProvider.players.length < 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Debe haber al menos 4 jugadores para crear parejas.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
        return;
      }
      if (playerProvider.players.length % 2 != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'El total de jugadores debe ser par para crear parejas.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
        return;
      }
      playerProvider.createPairs();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PairsScreen()),
      );
    }

    // If there are pairs, show the button to view them
    showPairs() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PairsScreen()),
      );
    }

    if (playerProvider.pairs.isNotEmpty) {
      return ElevatedButton(
        onPressed: showPairs,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: const Text('Ver Parejas'),
      );
    }

    return ElevatedButton(
      onPressed: createPairs,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: const Text('Crear Parejas'),
    );
  }
}
