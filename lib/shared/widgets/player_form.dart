import 'package:amigo_secreto_app/entities/player.dart';
import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerForm extends StatefulWidget {
  const PlayerForm({super.key});

  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';
  int age = 0;
  List<String> gifts = [];

  

  @override
  Widget build(BuildContext context) {
  final playerProvider = context.watch<PlayerProvider>();
  final colors = Theme.of(context).colorScheme;
  onSubmit() {

    if (!_formKey.currentState!.validate()) {
      return; // Si el formulario no es válido, no hacemos nada
    }

    
    final newPlayer = Player(name: name, age: age, gifts: gifts);
    playerProvider.addPlayer(newPlayer);

    // Aquí puedes agregar la lógica para guardar el jugador
    // Por ejemplo, llamar a un método en tu proveedor de jugadores

    Navigator.pop(context); // Cierra el modal después de agregar el jugador
  }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Agregar Jugador',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  label: 'Nombre y apellido',
                  onChanged: (value) => name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Por favor, ingresa un nombre';
                    if (value.length < 3) return 'El nombre debe tener al menos 3 caracteres';
                    if (value.length > 50) return 'El nombre no puede tener más de 50 caracteres';

                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Edad',
                  onChanged: (value) => age = int.tryParse(value) ?? 0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa una edad';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0) {
                      return 'Por favor, ingresa una edad válida';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Regalos (Separados por comas y maximo 2 opciones)',
                  onChanged: (value) {
                    setState(() {
                      gifts = value.split(',').map((gift) => gift.trim()).toList();
                      if (gifts.length > 2) {
                        gifts = gifts.sublist(0, 2); // Limitar a 2 regalos
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa al menos un regalo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Agregar Jugador', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}