import 'package:uuid/uuid.dart';

enum Gender {
  male("Masculino"),
  female("Femenino"),
  other("Otro");

  final String label;
  const Gender(this.label);
}

class Player {
  final String id = Uuid().v4();
  final String name;
  final int age;
  final Gender gender;
  final List<String> gifts;

  Player({
    required this.name,
    required this.age,
    required this.gender,
    required this.gifts,
  });
}