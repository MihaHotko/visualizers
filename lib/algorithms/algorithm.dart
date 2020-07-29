import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Node.dart';

abstract class Algorithm {
  List<Node> getNodesInShortestPath(Node finishNode) {
    List<Node> shortestPath = [];
    var currentNode = finishNode;
    if (currentNode.previousNode == null) return [];
    while (currentNode != null) {
      shortestPath.insert(0, currentNode);
      if (currentNode.type != NodeType.finishVisited &&
          currentNode.type != NodeType.startVisited) {
        currentNode.type = NodeType.shortestPath;
      }
      currentNode = currentNode.previousNode;
    }
    return shortestPath;
  }

  List<Node> getUnvisitedNeighbours(Node a, List<Node> grid) {
    List<Node> neigbours = [];
    var col = a.col;
    var row = a.row;

    if (row > 1) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) - Constants.ROWS;
      if (_checkIfNotVisited(grid[index])) neigbours.add(grid[index]);
    }
    if (row < Constants.COLS) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) + Constants.ROWS;
      if (_checkIfNotVisited(grid[index])) neigbours.add(grid[index]);
    }
    if (col > 1) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) - 1;
      if (_checkIfNotVisited(grid[index])) neigbours.add(grid[index]);
    }
    if (col < Constants.ROWS) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) + 1;
      if (_checkIfNotVisited(grid[index])) neigbours.add(grid[index]);
    }
    return neigbours;
  }

  bool _checkIfNotVisited(Node n) {
    if (n.type != NodeType.visited &&
        n.type != NodeType.startVisited &&
        n.type != NodeType.finishVisited) {
      return true;
    }
    return false;
  }

  List<Node> algorithm(List<Node> grid, Node startNode, Node finishNode);
}
