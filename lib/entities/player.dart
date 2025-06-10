import 'package:uuid/uuid.dart';

class Player {
  final String id = Uuid().v4();
  final String name;
  final int age;
  final List<String> gifts;

  Player({
    required this.name,
    required this.age,
    required this.gifts,
  });


}