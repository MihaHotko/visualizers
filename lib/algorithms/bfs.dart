import 'package:visualizer/algorithms/algorithm.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Node.dart';

class BFS extends Algorithm {
  @override
  List<Node> algorithm(List<Node> grid, Node startNode, Node finishNode) {
    List<Node> queue = List<Node>();
    List<Node> visitedNodes = List<Node>();

    queue.add(startNode);

    while (queue.isNotEmpty) {
      var currentNode = queue.removeAt(0);

      if (currentNode.type == NodeType.wall) {
        continue;
      }

      switch (currentNode.type) {
        case NodeType.start:
          currentNode.type = NodeType.startVisited;
          break;
        case NodeType.finish:
          currentNode.type = NodeType.finishVisited;
          break;
        default:
          currentNode.type = NodeType.visited;
          break;
      }

      visitedNodes.add(currentNode);

      var neighbours = getUnvisitedNeighbours(currentNode, grid);
      for (Node n in neighbours) {
        if (n.type == NodeType.wall) {
          continue;
        }
        queue.add(n);
        n.previousNode = currentNode;
        if (n.type == NodeType.finish) {
          n.type = NodeType.finishVisited;
          visitedNodes.add(n);
          return visitedNodes;
        }
        n.type = NodeType.visited;
      }
    }

    return visitedNodes;
  }
}
