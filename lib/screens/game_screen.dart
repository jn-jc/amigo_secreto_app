import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/screens/home_screen.dart';
import 'package:amigo_secreto_app/screens/rules_screen.dart';
import 'package:amigo_secreto_app/shared/widgets/pairs_button.dart';
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
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RulesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Jugadores',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Minimo 4 jugadores para crear parejas',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: playersProvider.players.isNotEmpty
                  ? Scrollbar(
                    thumbVisibility: true,
                    thickness: 5,
                    radius: const Radius.circular(10),
                    trackVisibility: false,
                    child: ListView.builder(
                        itemCount: playersProvider.players.length,
                        itemBuilder: (context, index) {
                          final player = playersProvider.players[index];
                          final isLast = index == playersProvider.players.length - 1;
                          return Column(
                            children: [
                              PlayerContainer(
                                playerName: player.name.split(' ').first,
                                playerAge: player.age,
                                playerGifts: player.gifts,
                                onEdit: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 3.0),
                                          child: PlayerForm(player: player),
                                        ),
                                      );
                                    },
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                  );
                                },
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
                                              playersProvider.clearPairs();
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
                              ),
                              if (isLast && playersProvider.pairs.isEmpty) const SizedBox(height: 90),
                            ],
                          );
                        },
                      ),
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
      floatingActionButton: playersProvider.pairs.isEmpty ? FloatingActionButton(
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
      ) : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Navigate to home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            const PairsButton(),
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
