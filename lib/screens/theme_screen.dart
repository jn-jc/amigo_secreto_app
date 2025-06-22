import 'package:amigo_secreto_app/providers/color_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorThemeProvider>();
    final selectedIndex = colorProvider.selectedColorTheme;
    final colors = colorProvider.themeColorList;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Color del Tema',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Selecciona tu color favorito para usar en la app',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return InkWell(
                  onTap: () {
                    // Cambia el tema de color al que se ha seleccionado
                    context.read<ColorThemeProvider>().setColorTheme(index);
                  },
                  child: Container(
                    margin: isSelected
                        ? const EdgeInsets.all(
                            4.0,
                          ) // padding extra si es seleccionado
                        : const EdgeInsets.all(
                            0.0,
                          ), // padding normal si no es seleccionado
                    height: 85,
                    decoration: BoxDecoration(
                      borderRadius: isSelected
                          ? BorderRadius.circular(6)
                          : BorderRadius.circular(0),
                      color: colors[index]['color'] as Color,
                    ),
                    child: Center(
                      child: Text(
                        '${colors[index]['colorName']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
