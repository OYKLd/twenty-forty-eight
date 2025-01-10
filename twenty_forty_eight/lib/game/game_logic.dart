import 'dart:math';

class Game2048 {
  // Initialisation directe pour éviter l'erreur
  List<List<int>> grid = List.generate(4, (_) => List.filled(4, 0)); 
  int score = 0;
  final Random random = Random();

  Game2048() {
    _addRandomTile();
    _addRandomTile();
  }

  // Déplacement vers la gauche
  void moveLeft() {
    for (int row = 0; row < 4; row++) {
      List<int> currentRow = grid[row].where((value) => value != 0).toList();

      for (int i = 0; i < currentRow.length - 1; i++) {
        if (currentRow[i] == currentRow[i + 1]) {
          currentRow[i] *= 2;
          score += currentRow[i];
          currentRow[i + 1] = 0;
        }
      }

      currentRow.removeWhere((value) => value == 0);
      grid[row] = List.filled(4, 0);
      for (int i = 0; i < currentRow.length; i++) {
        grid[row][i] = currentRow[i];
      }
    }
    _addRandomTile();
  }

  // Déplacement vers la droite
  void moveRight() {
    for (int row = 0; row < 4; row++) {
      List<int> currentRow = grid[row].where((value) => value != 0).toList();

      for (int i = currentRow.length - 1; i > 0; i--) {
        if (currentRow[i] == currentRow[i - 1]) {
          currentRow[i] *= 2;
          score += currentRow[i];
          currentRow[i - 1] = 0;
        }
      }

      currentRow.removeWhere((value) => value == 0);
      grid[row] = List.filled(4, 0);
      for (int i = 0; i < currentRow.length; i++) {
        grid[row][3 - i] = currentRow[currentRow.length - 1 - i];
      }
    }
    _addRandomTile();
  }

  // Déplacement vers le haut
  void moveUp() {
    for (int col = 0; col < 4; col++) {
      List<int> currentCol = [];

      for (int row = 0; row < 4; row++) {
        if (grid[row][col] != 0) {
          currentCol.add(grid[row][col]);
        }
      }

      for (int i = 0; i < currentCol.length - 1; i++) {
        if (currentCol[i] == currentCol[i + 1]) {
          currentCol[i] *= 2;
          score += currentCol[i];
          currentCol[i + 1] = 0;
        }
      }

      currentCol.removeWhere((value) => value == 0);
      for (int row = 0; row < 4; row++) {
        grid[row][col] = row < currentCol.length ? currentCol[row] : 0;
      }
    }
    _addRandomTile();
  }

  // Déplacement vers le bas
  void moveDown() {
    for (int col = 0; col < 4; col++) {
      List<int> currentCol = [];

      for (int row = 0; row < 4; row++) {
        if (grid[row][col] != 0) {
          currentCol.add(grid[row][col]);
        }
      }

      for (int i = currentCol.length - 1; i > 0; i--) {
        if (currentCol[i] == currentCol[i - 1]) {
          currentCol[i] *= 2;
          score += currentCol[i];
          currentCol[i - 1] = 0;
        }
      }

      currentCol.removeWhere((value) => value == 0);
      for (int row = 0; row < 4; row++) {
        grid[row][col] =
            row >= 4 - currentCol.length ? currentCol[row - (4 - currentCol.length)] : 0;
      }
    }
    _addRandomTile();
  }

  // Vérifie si le jeu est terminé
  bool isGameOver() {
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 0) return false; // Case vide
        if (col < 3 && grid[row][col] == grid[row][col + 1]) return false; // Adjacent horizontal
        if (row < 3 && grid[row][col] == grid[row + 1][col]) return false; // Adjacent vertical
      }
    }
    return true; // Pas de mouvements disponibles
  }

  // Ajoute une tuile aléatoire
  void _addRandomTile() {
    List<int> emptyCells = [];
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 0) emptyCells.add(row * 4 + col);
      }
    }
    if (emptyCells.isNotEmpty) {
      int index = emptyCells[random.nextInt(emptyCells.length)];
      grid[index ~/ 4][index % 4] = random.nextBool() ? 2 : 4;
    }
  }
}
