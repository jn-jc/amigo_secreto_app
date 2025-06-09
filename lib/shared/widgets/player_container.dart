import 'package:flutter/material.dart';

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          'User',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}