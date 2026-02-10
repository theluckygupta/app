enum Direction {
  up,
  right,
  down,
  left;

  Direction rotateClockwise() => values[(index + 1) % values.length];
}

class ArrowTile {
  ArrowTile(this.direction, {this.locked = false});

  Direction direction;
  final bool locked;

  void rotate() {
    if (!locked) {
      direction = direction.rotateClockwise();
    }
  }
}

class BoardPosition {
  const BoardPosition(this.row, this.col);

  final int row;
  final int col;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardPosition && runtimeType == other.runtimeType && row == other.row && col == other.col;

  @override
  int get hashCode => Object.hash(row, col);
}

class ArrowPuzzleState {
  ArrowPuzzleState({
    required this.board,
    required this.start,
    required this.goal,
    this.moves = 0,
  });

  final List<List<ArrowTile>> board;
  final BoardPosition start;
  final BoardPosition goal;
  int moves;

  int get size => board.length;

  bool rotateAt(int row, int col) {
    if (row < 0 || col < 0 || row >= size || col >= size) {
      return false;
    }
    board[row][col].rotate();
    moves += 1;
    return true;
  }

  bool isSolved() {
    var current = start;
    final visited = <BoardPosition>{};

    while (true) {
      if (current == goal) {
        return true;
      }

      if (!visited.add(current)) {
        return false;
      }

      final tile = board[current.row][current.col];
      final next = _nextPosition(current, tile.direction);
      if (next == null) {
        return false;
      }

      current = next;
    }
  }

  BoardPosition? _nextPosition(BoardPosition position, Direction direction) {
    switch (direction) {
      case Direction.up:
        final row = position.row - 1;
        return row >= 0 ? BoardPosition(row, position.col) : null;
      case Direction.right:
        final col = position.col + 1;
        return col < size ? BoardPosition(position.row, col) : null;
      case Direction.down:
        final row = position.row + 1;
        return row < size ? BoardPosition(row, position.col) : null;
      case Direction.left:
        final col = position.col - 1;
        return col >= 0 ? BoardPosition(position.row, col) : null;
    }
  }
}

ArrowPuzzleState buildStarterLevel() {
  return ArrowPuzzleState(
    board: [
      [ArrowTile(Direction.right, locked: true), ArrowTile(Direction.down), ArrowTile(Direction.left)],
      [ArrowTile(Direction.up), ArrowTile(Direction.right), ArrowTile(Direction.down)],
      [ArrowTile(Direction.right), ArrowTile(Direction.up), ArrowTile(Direction.up, locked: true)],
    ],
    start: const BoardPosition(0, 0),
    goal: const BoardPosition(2, 2),
  );
}
