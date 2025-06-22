import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/shared/widgets/pairs_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PairsScreen extends StatelessWidget {
  const PairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playersProvider = context.watch<PlayerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parejas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: playersProvider.pairs.length,
          itemBuilder: (context, index) {
            final pair = playersProvider.pairs[index];
            return PairsContainer(
              player1: pair[0].name,
              player2: pair[1].name,
              giftsForPlayer1: pair[0].gifts.join(', '),
              giftsForPlayer2: pair[1].gifts.join(', '),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 65,
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Reiniciar Parejas'),
                  content: const Text(
                    '¿Estás seguro de que quieres reiniciar las parejas?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        playersProvider.createPairs();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Reiniciar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white, size: 30),
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Eliminar Parejas'),
                  content: const Text(
                    '¿Estás seguro de que quieres eliminar las parejas?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        playersProvider.clearPairs();
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              icon: Icon(Icons.delete_forever, color: Colors.red, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
