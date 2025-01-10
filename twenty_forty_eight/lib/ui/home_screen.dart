import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(Game2048App());
}

class Game2048App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Color(0xFFFAF8EF),
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int gridSize = 4;
  List<List<int>> grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
  int score = 0;
  int bestScore = 0;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
      score = 0;
      addRandomTile();
      addRandomTile();
    });
  }

  void addRandomTile() {
    List<Point> emptyTiles = [];
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) {
          emptyTiles.add(Point(i, j));
        }
      }
    }

    if (emptyTiles.isNotEmpty) {
      Point randomPoint = emptyTiles[random.nextInt(emptyTiles.length)];
      grid[randomPoint.x.toInt()][randomPoint.y.toInt()] = random.nextDouble() < 0.9 ? 2 : 4;
    }
  }

  Color getTileColor(int value) {
    switch (value) {
      case 2: return Color(0xFFEEE4DA);
      case 4: return Color(0xFFEDE0C8);
      case 8: return Color(0xFFF2B179);
      case 16: return Color(0xFFF59563);
      case 32: return Color(0xFFF67C5F);
      case 64: return Color(0xFFF65E3B);
      case 128: return Color(0xFFEDCF72);
      case 256: return Color(0xFFEDCC61);
      case 512: return Color(0xFFEDC850);
      case 1024: return Color(0xFFEDC53F);
      case 2048: return Color(0xFFEDC22E);
      default: return Color(0xFFCDC1B4);
    }
  }

  Color getTextColor(int value) {
    return value <= 4 ? Colors.grey[700]! : Colors.white;
  }

  bool move(Direction direction) {
    bool moved = false;
    List<List<int>> oldGrid = List.generate(
      gridSize,
      (i) => List.from(grid[i]),
    );

    switch (direction) {
      case Direction.up:
        moved = moveUp();
        break;
      case Direction.down:
        moved = moveDown();
        break;
      case Direction.left:
        moved = moveLeft();
        break;
      case Direction.right:
        moved = moveRight();
        break;
    }

    if (moved) {
      addRandomTile();
      if (score > bestScore) {
        bestScore = score;
      }
    }

    return moved;
  }

  bool moveLeft() {
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = grid[i];
      List<int> newRow = merge(row);
      if (row.join() != newRow.join()) {
        moved = true;
        grid[i] = newRow;
      }
    }
    return moved;
  }

  bool moveRight() {
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = grid[i].reversed.toList();
      List<int> newRow = merge(row).reversed.toList();
      if (grid[i].join() != newRow.join()) {
        moved = true;
        grid[i] = newRow;
      }
    }
    return moved;
  }

  bool moveUp() {
    bool moved = false;
    for (int j = 0; j < gridSize; j++) {
      List<int> column = [for (int i = 0; i < gridSize; i++) grid[i][j]];
      List<int> newColumn = merge(column);
      if (column.join() != newColumn.join()) {
        moved = true;
        for (int i = 0; i < gridSize; i++) {
          grid[i][j] = newColumn[i];
        }
      }
    }
    return moved;
  }

  bool moveDown() {
    bool moved = false;
    for (int j = 0; j < gridSize; j++) {
      List<int> column = [for (int i = gridSize - 1; i >= 0; i--) grid[i][j]];
      List<int> newColumn = merge(column);
      if (column.join() != newColumn.join()) {
        moved = true;
        for (int i = 0; i < gridSize; i++) {
          grid[gridSize - 1 - i][j] = newColumn[i];
        }
      }
    }
    return moved;
  }

  List<int> merge(List<int> line) {
    List<int> result = List.filled(gridSize, 0);
    int index = 0;
    int? lastMerged;

    for (int i = 0; i < gridSize; i++) {
      if (line[i] != 0) {
        if (lastMerged == null) {
          lastMerged = line[i];
        } else if (lastMerged == line[i]) {
          result[index] = lastMerged * 2;
          score += result[index];
          lastMerged = null;
          index++;
        } else {
          result[index] = lastMerged;
          lastMerged = line[i];
          index++;
        }
      }
    }

    if (lastMerged != null) {
      result[index] = lastMerged;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2048'),
        backgroundColor: Color(0xFF8F7A66),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ScoreBoard(title: 'Score', score: score),
                ScoreBoard(title: 'Best', score: bestScore),
              ],
            ),
          ),
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy < 0) {
                move(Direction.up);
              } else {
                move(Direction.down);
              }
              setState(() {});
            },
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx < 0) {
                move(Direction.left);
              } else {
                move(Direction.right);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFBBADA0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: List.generate(
                  gridSize,
                  (i) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      gridSize,
                      (j) => Tile(
                        value: grid[i][j],
                        backgroundColor: getTileColor(grid[i][j]),
                        textColor: getTextColor(grid[i][j]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: startGame,
            child: Text('New Game'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8F7A66),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  final String title;
  final int score;

  ScoreBoard({required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFBBADA0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            score.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int value;
  final Color backgroundColor;
  final Color textColor;

  Tile({
    required this.value,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: value == 0 ? Color(0xFFCDC1B4) : backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(
            fontSize: value < 100 ? 24 : value < 1000 ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

enum Direction { up, down, left, right }