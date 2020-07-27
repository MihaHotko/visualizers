import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Node.dart';

class Grid {
  static num _rows = Constants.ROWS;
  static num _cols = Constants.COLS;
  static List<Node> grid = List<Node>();

  Grid();

  static Node getNode(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    return grid[index];
  }

  static List<Node> toggleNode(List<Node> grid, num row, num col, NodeType n1,
      [NodeType n2]) {
    num index = (row - 1) * _rows + (col - 1);
    if (n2 != null) {
      grid[index].type = grid[index].type == n1 ? n2 : n1;
    } else {
      grid[index].type = n1;
    }
    return grid;
  }

  static List<Node> toggleWall(List<Node> grid, num row, num col) {
    num index = (row - 1) * _rows + (col - 1);
    if (grid[index].type != NodeType.start &&
        grid[index].type != NodeType.finish) {
      grid[index].type =
          grid[index].type == NodeType.wall ? NodeType.blank : NodeType.wall;
    }
    return grid;
  }

  static int _fast_mod(int input, int ceil) {
    return input >= ceil ? input % ceil : input;
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
