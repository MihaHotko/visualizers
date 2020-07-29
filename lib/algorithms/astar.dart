import 'package:visualizer/algorithms/algorithm.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Node.dart';

class AStar extends Algorithm {
  static var f_cost = Map<Node, num>();

  @override
  List<Node> algorithm(List<Node> grid, Node startNode, Node finishNode) {
    var open = Map<Node, num>();
    var closed = List<Node>();

    open[startNode] = 0;

    f_cost[startNode] = heuristic(startNode, finishNode);
    // Node.distance is the g score
    startNode.distance = 0;

    while (open.isNotEmpty) {
      var currentNode = getMinFromOpen(open);

      if (currentNode.type == NodeType.finish) {
        currentNode.type = NodeType.finishVisited;
        return closed;
      }
      open.remove(currentNode);
      closed.add(currentNode);

      if (currentNode.type == NodeType.wall) continue;

      switch (currentNode.type) {
        case NodeType.start:
          currentNode.type = NodeType.startVisited;
          break;
        default:
          currentNode.type = NodeType.visited;
          break;
      }

      var unvisitedNeighbors = getUnvisitedNeighbours(currentNode, grid);
      for (var neighbour in unvisitedNeighbors) {
        num tentativeGScore = currentNode.distance + 1;

        if (tentativeGScore < neighbour.distance) {
          neighbour.previousNode = currentNode;
          neighbour.distance = tentativeGScore;
          f_cost[neighbour] =
              neighbour.distance + heuristic(neighbour, finishNode);
          if (!open.containsKey(neighbour)) {
            open[neighbour] = f_cost[neighbour];
          }
        }
      }
    }
    return closed;
  }

  num heuristic(Node a, Node b) {
    // Manhattan distance heuristic
    return (a.col - b.col).abs() + (a.row - b.row).abs();
  }

  Node getMinFromOpen(Map<Node, num> map) {
    Node minKey = null;
    num minValue = double.infinity;
    for (Node key in map.keys) {
      num value = map[key];
      if (value < minValue) {
        minValue = value;
        minKey = key;
      }
    }
    return minKey;
  }
}
