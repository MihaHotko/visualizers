import 'package:visualizer/algorithms/algorithm.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Node.dart';

class DFS extends Algorithm {
  @override
  List<Node> algorithm(List<Node> grid, Node startNode, Node finishNode) {
    List<Node> stack = [];
    List<Node> visitedInOrder = [];
    stack.add(startNode);
    //print(visitedInOrder);
    while (stack.isNotEmpty) {
      var currentNode = stack.removeLast();

      if (currentNode.type == NodeType.wall) {
        continue;
      }
      visitedInOrder.add(currentNode);

      switch (currentNode.type) {
        case NodeType.start:
          currentNode.type = NodeType.startVisited;
          break;
        default:
          currentNode.type = NodeType.visited;
          break;
      }

      var neighbours = getUnvisitedNeighbours(currentNode, grid);
      for (Node neigbour in neighbours) {
        stack.add(neigbour);
        neigbour.previousNode = currentNode;
        if (neigbour.type == NodeType.finish) {
          neigbour.type = NodeType.finishVisited;
          return visitedInOrder;
        }
      }
    }
    return visitedInOrder;
  }
}
