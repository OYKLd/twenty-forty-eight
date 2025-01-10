import 'package:flutter/material.dart';
import '../game/game_logic.dart';

class TileWidget extends StatelessWidget {
  final Game2048 game;

  const TileWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        int row = index ~/ 4;
        int col = index % 4;
        int value = game.grid[row][col];

        return Container(
          decoration: BoxDecoration(
            color: value == 0 ? Colors.grey[300] : Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              value == 0 ? '' : '$value',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
