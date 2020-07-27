import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/enums/node_types.dart';

class Node {
  bool isStart;
  bool isFinish;
  bool isWall;
  bool isVisited;
  num col;
  num row;
  num distance;
  Node previousNode;
  num index;
  NodeType type;

  Node(
      {this.isStart,
      this.isFinish,
      this.isWall,
      this.isVisited,
      this.col,
      this.row,
      this.distance,
      this.index,
      this.previousNode});

  static Node createNode(num col, num row) {
    return Node(
        index: col + row,
        col: col,
        row: row,
        isStart:
            col == Constants.START_NODE_COL && row == Constants.START_NODE_ROW,
        isFinish:
            col == Constants.END_NODE_COL && row == Constants.END_NODE_ROW,
        distance: double.infinity,
        isWall: false,
        isVisited: false);
  }

  @override
  String toString() {
    return 'Node(isStart: $isStart, isFinish: $isFinish, isWall: $isWall, isVisited: $isVisited, col: $col, row: $row, distance: $distance, index: $index';
  }
}
