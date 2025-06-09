import 'package:amigo_secreto_app/entities/player.dart';
import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier{
  final List<Player> _players = [];
  final List<Player> _pairs = [];

  List<Player> get players => _players;

  void addPlayer(Player player) {
    if (player.name.isNotEmpty && !_players.contains(player)) {
      _players.add(player);
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

  void createPairs() {
    if (_players.length < 6) {
      throw Exception('Not enough players to create pairs');
    }
    _players.shuffle();
    _pairs.clear();
    for (int i = 0; i < _players.length; i++) {
      final giver = _players[i];
      final receiver = _players[(i + 1) % _players.length];
      giver.gifts.clear(); // Clear previous gifts
      giver.gifts.add(receiver.name); // Add the receiver's name as a gift
      _pairs.add(giver);
    }
  }
}