import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/shared/widgets/player_container.dart';
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
        title: const Text(
          'Amigo Secreto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
              child: playersProvider.players.isNotEmpty
                  ? ListView.builder(
                      itemCount: playersProvider.players.length,
                      itemBuilder: (context, index) {
                        final player = playersProvider.players[index];
                        return PlayerContainer(
                          playerName: player.name,
                          playerAge: player.age,
                          playerGifts: player.gifts,
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Eliminar Jugador'),
                                  content: const Text(
                                    '¿Estás seguro de que quieres eliminar este jugador?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        playersProvider.removePlayer(player);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No hay jugadores agregados',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: const PlayerForm(),
                ),
              );
            },
            isScrollControlled: true,
            useSafeArea: true,
          );
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
                        playersProvider.clearPlayers();
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
