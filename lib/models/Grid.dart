import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/models/Node.dart';

class Grid {
  static num _rows = Constants.ROWS;
  static num _cols = Constants.COLS;
  static List<Node> grid = List<Node>();

  Grid();

  static List<Node> toggleWall(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    if (!grid[index].isStart && !grid[index].isFinish) {
      grid[index].isWall = !grid[index].isWall;
    }
    return grid;
  }

  static List<Node> toggleStart(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    grid[index].isStart = !grid[index].isStart;
    return grid;
  }

  static List<Node> disableStart(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    grid[index].isStart = false;
    return grid;
  }

  static List<Node> disableFinish(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    grid[index].isFinish = false;
    return grid;
  }

  static List<Node> toggleFinish(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);

    grid[index].isFinish = !grid[index].isFinish;

    return grid;
  }

  static bool isStart(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    return grid[index].isStart;
  }

  static bool isFinish(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    return grid[index].isFinish;
  }

  static int _fast_mod(int input, int ceil) {
    return input >= ceil ? input % ceil : input;
  }

  static num getRow(num col) {
    return (col / _rows).floor();
  }

  static num getCol(num col) {
    return _fast_mod(col, _rows);
  }

  static List<Node> getInitialGrid() {
    if (grid.length != 0) grid.clear();
    for (var i = 0; i < (_rows * _cols); i++) {
      var y = (i / _rows).floor();
      var x = _fast_mod(i, _rows);
      var node = Node.createNode(x + 1, y + 1);
      grid.add(node);
    }
    return grid;
  }
}
