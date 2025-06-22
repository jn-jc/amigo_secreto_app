import 'package:uuid/uuid.dart';

extension StringExtension on String {
  String get capitalize => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
}

class Player {
  final String id = Uuid().v4();
  String name;
  int age;
  List<String> gifts;

  Player({
    required String name,
    required this.age,
    required this.gifts,
  }) : name = name.capitalize;


}