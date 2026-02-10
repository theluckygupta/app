import 'package:flutter_test/flutter_test.dart';

import 'package:arrow_puzzle_mobile/game_logic.dart';

void main() {
  test('locked tiles do not rotate', () {
    final tile = ArrowTile(Direction.up, locked: true);
    tile.rotate();
    expect(tile.direction, Direction.up);
  });

  test('rotateAt increases moves', () {
    final state = buildStarterLevel();
    expect(state.moves, 0);
    state.rotateAt(1, 1);
    expect(state.moves, 1);
  });

  test('state is solvable after known sequence', () {
    final state = buildStarterLevel();

    state.rotateAt(0, 1); // down -> left
    state.rotateAt(1, 0); // up -> right
    state.rotateAt(1, 2); // down -> left
    state.rotateAt(2, 0); // right (unchanged path here)
    state.rotateAt(2, 1); // up -> right

    expect(state.isSolved(), isTrue);
  });
}
