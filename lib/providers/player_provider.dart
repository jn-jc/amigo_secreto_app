import 'package:amigo_secreto_app/entities/player.dart';
import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier{
  final List<Player> _players = [];
  final List<List<Player>> _pairs = [];

  List<Player> get players => _players;
  List<List<Player>> get pairs => _pairs;

  void addPlayer(Player player) {
    if (player.name.isNotEmpty && !_players.contains(player)) {
      _players.add(player);
      notifyListeners();
    }
  }
  void updatePlayer(Player oldPlayer, Player newPlayer) {
    final index = _players.indexOf(oldPlayer);
    if (index != -1 && newPlayer.name.isNotEmpty) {
      _players[index].name = newPlayer.name;
      _players[index].age = newPlayer.age;
      _players[index].gifts = newPlayer.gifts;
      notifyListeners();
    }
  }
  void removePlayer(Player player) {
    if (_players.contains(player)) {
      _players.remove(player);
      notifyListeners();
    }
  }
  void clearPlayers() {
    _players.clear();
    notifyListeners();
  }

  void clearPairs() {
    _pairs.clear();
    notifyListeners();
  }

  void createPairs() {
    if (_players.length < 4) {
      throw Exception('Not enough players to create pairs');
    }
    _players.shuffle();
    _pairs.clear();
    for (int i = 0; i < _players.length; i += 2) {
      final player1 = _players[i];
      final player2 = _players[(i + 1) % _players.length]; // Pair with the next player, wrapping around
      _pairs.add([player1, player2]);
    }
    notifyListeners();
  }
}