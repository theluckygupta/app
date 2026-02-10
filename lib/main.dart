import 'package:flutter/material.dart';

import 'game_logic.dart';

void main() {
  runApp(const ArrowPuzzleApp());
}

class ArrowPuzzleApp extends StatelessWidget {
  const ArrowPuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arrow Puzzle',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const ArrowPuzzlePage(),
    );
  }
}

class ArrowPuzzlePage extends StatefulWidget {
  const ArrowPuzzlePage({super.key});

  @override
  State<ArrowPuzzlePage> createState() => _ArrowPuzzlePageState();
}

class _ArrowPuzzlePageState extends State<ArrowPuzzlePage> {
  late ArrowPuzzleState _state;

  @override
  void initState() {
    super.initState();
    _state = buildStarterLevel();
  }

  void _rotateTile(int row, int col) {
    setState(() {
      _state.rotateAt(row, col);
    });

    if (_state.isSolved()) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Puzzle solved!'),
          content: Text('You reached the goal in ${_state.moves} moves.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _state = buildStarterLevel();
                });
              },
              child: const Text('Play again'),
            ),
          ],
        ),
      );
    }
  }

  IconData _iconFor(Direction direction) {
    switch (direction) {
      case Direction.up:
        return Icons.keyboard_arrow_up;
      case Direction.right:
        return Icons.keyboard_arrow_right;
      case Direction.down:
        return Icons.keyboard_arrow_down;
      case Direction.left:
        return Icons.keyboard_arrow_left;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrow Puzzle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tap tiles to rotate arrows and connect start to goal.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text('Moves: ${_state.moves}'),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: _state.size * _state.size,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _state.size,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ _state.size;
                  final col = index % _state.size;
                  final tile = _state.board[row][col];

                  final isStart = _state.start.row == row && _state.start.col == col;
                  final isGoal = _state.goal.row == row && _state.goal.col == col;

                  return Material(
                    color: tile.locked ? Colors.deepPurple.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: tile.locked ? null : () => _rotateTile(row, col),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              _iconFor(tile.direction),
                              size: 48,
                              color: Colors.deepPurple,
                            ),
                          ),
                          if (isStart)
                            const Positioned(
                              left: 6,
                              top: 6,
                              child: Chip(label: Text('S')),
                            ),
                          if (isGoal)
                            const Positioned(
                              right: 6,
                              bottom: 6,
                              child: Chip(label: Text('G')),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  _state = buildStarterLevel();
                });
              },
              child: const Text('Reset level'),
            ),
          ],
        ),
      ),
    );
  }
}
