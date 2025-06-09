import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/shared/widgets/player_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final playersProvider = context.watch<PlayerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amigo Secreto', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Jugadores',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: playersProvider.players.length,
                itemBuilder: (context, index) {
                  final player = playersProvider.players[index];
                  return ListTile(
                    title: Text(player.name),
                    subtitle: Text('Regalo escogido: ${player.gifts.join(', ')}'),
                  );
                },
              ),
            ),
          ],
        ),
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) {
            return const PlayerForm();
          });
        }, // Add your action here
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Navigate to home screen
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Reinicar Juego'),
                  content: const Text(
                    '¿Estás seguro de que quieres reiniciar el juego?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Logic to reset the game
                        Navigator.of(context).pop();
                      },
                      child: const Text('Reiniciar'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
