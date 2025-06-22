import 'package:amigo_secreto_app/entities/player.dart';
import 'package:amigo_secreto_app/providers/player_provider.dart';
import 'package:amigo_secreto_app/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerForm extends StatefulWidget {
  final Player? player; // Parámetro opcional para editar un jugador existente
  const PlayerForm({super.key, this.player});

  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _giftsController;

  late List<String> gifts;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.player?.name ?? '');
    _ageController = TextEditingController(
      text: widget.player != null ? widget.player!.age.toString() : '',
    );
    _giftsController = TextEditingController(
      text: widget.player != null ? widget.player!.gifts.join(', ') : '',
    );
    gifts = widget.player?.gifts ?? [];
    if (gifts.length > 2) {
      gifts = gifts.sublist(0, 2); // Limitar a 2 regalos
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.watch<PlayerProvider>();
    final titleText = widget.player == null
        ? 'Agregar Jugador'
        : 'Editar Jugador';
    final colors = Theme.of(context).colorScheme;

    onSubmit() {
      if (!_formKey.currentState!.validate()) return; // Si el formulario no es válido, no hacemos nada

      final name = _nameController.text.trim();
      final age = int.tryParse(_ageController.text.trim()) ?? 0;
      final gifts = _giftsController.text
          .split(',')
          .map((gift) => gift.trim())
          .where((gift) => gift.isNotEmpty)
          .toList();

      if (gifts.length > 2) {
        gifts.removeRange(2, gifts.length);
      }
      final newPlayer = Player(name: name, age: age, gifts: gifts);
      if (widget.player == null) {
        // Si estamos editando un jugador existente, actualizamos
        playerProvider.addPlayer(newPlayer);
      } else {
        // Si es un nuevo jugador, lo agregamos
        playerProvider.updatePlayer(widget.player!, newPlayer);
      }
      Navigator.pop(context); // Cierra el modal después de agregar el jugador
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            titleText,
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
                  label: 'Nombre',
                  controller: _nameController,
                  onChanged: (value) => {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un nombre';
                    }
                    if (value.length < 3) {
                      return 'El nombre debe tener al menos 3 caracteres';
                    }
                    if (value.length > 50) {
                      return 'El nombre no puede tener más de 50 caracteres';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  label: 'Edad',
                  controller: _ageController,
                  onChanged: (value) => {},
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
                  controller: _giftsController,
                  onChanged: (value) {},
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
                      Icon(
                        widget.player == null ? Icons.add : Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(titleText, style: TextStyle(color: Colors.white)),
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
