import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/enums/node_types.dart';

class Node {
  // bool isStart;
  // bool isFinish;
  // bool isWall;
  // bool isVisited;
  num col;
  num row;
  num distance;
  Node previousNode;
  num index;
  NodeType type;

  Node(
      {this.col,
      this.type,
      this.row,
      this.distance,
      this.index,
      this.previousNode});

  static Node createNode(num col, num row) {
    var isStart =
        col == Constants.START_NODE_COL && row == Constants.START_NODE_ROW;
    var isFinish =
        col == Constants.END_NODE_COL && row == Constants.END_NODE_ROW;
    return Node(
        index: col + row,
        col: col,
        row: row,
        distance: double.infinity,
        type: isStart
            ? NodeType.start
            : isFinish ? NodeType.finish : NodeType.blank);
  }

  @override
  String toString() {
    return 'Node(col: $col, row: $row, distance: $distance, index: $index, type: $type)';
  }
}
