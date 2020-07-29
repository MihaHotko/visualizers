import 'dart:html';

import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/algorithms/algorithm.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Grid.dart';
import 'package:visualizer/models/Node.dart';

class Dijkstra extends Algorithm {
  @override
  List<Node> algorithm(List<Node> grid, Node startNode, Node finishNode) {
    List<Node> visitedNodesInOrder = [];
    startNode.distance = 0;
    var unvisitedNodes = List<Node>.from(grid);
    while (unvisitedNodes.length > 0) {
      unvisitedNodes
          .sort((nodeA, nodeB) => nodeA.distance.compareTo(nodeB.distance));

      var closestNode = unvisitedNodes.first;
      unvisitedNodes.removeAt(0);

      if (closestNode.type == NodeType.wall) continue;

      if (closestNode.distance == double.infinity) {
        return visitedNodesInOrder;
      }

      switch (closestNode.type) {
        case NodeType.start:
          closestNode.type = NodeType.startVisited;
          break;
        case NodeType.finish:
          closestNode.type = NodeType.finishVisited;
          break;
        default:
          closestNode.type = NodeType.visited;
          break;
      }
      visitedNodesInOrder.add(closestNode);
      if (closestNode == finishNode) return visitedNodesInOrder;
      updateVisitedNeighbors(closestNode, grid);
    }
  }

  void updateVisitedNeighbors(Node a, List<Node> grid) {
    var unvisitedNeighbors = getUnvisitedNeighbours(a, grid);
    for (var neighbour in unvisitedNeighbors) {
      neighbour.distance = a.distance + 1;
      neighbour.previousNode = a;
    }
  }
}
