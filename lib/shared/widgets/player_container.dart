import 'package:flutter/material.dart';

class PlayerContainer extends StatelessWidget {
  final String playerName;
  final int playerAge;
  final List<String> playerGifts;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const PlayerContainer({
    super.key,
    this.playerName = 'Default Name',
    this.playerAge = 0,
    this.playerGifts = const [],
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    playerName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Edad: $playerAge',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Regalos: ${playerGifts.join(', ')}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: onEdit,
                  ),
                  const SizedBox(height: 5.0),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 30,
                      color: Colors.red.shade800
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
