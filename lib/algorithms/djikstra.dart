import 'dart:html';

import 'package:visualizer/Constants/Constants.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Grid.dart';
import 'package:visualizer/models/Node.dart';

class Dijkstra {
  static List<Node> dijkstra(List<Node> grid, Node startNode, Node finishNode) {
    List<Node> visitedNodesInOrder = [];
    startNode.distance = 0;
    var unvisitedNodes = List<Node>.from(grid);
    print(startNode);
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

  static void updateVisitedNeighbors(Node a, List<Node> grid) {
    var unvisitedNeighbors = getUnvisitedNeighbours(a, grid);
    for (var neighbour in unvisitedNeighbors) {
      neighbour.distance = a.distance + 1;
      neighbour.previousNode = a;
    }
  }

  static List<Node> getUnvisitedNeighbours(Node a, List<Node> grid) {
    var neigbours = [];
    var col = a.col;
    var row = a.row;

    if (row > 1) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) - Constants.ROWS;
      neigbours.add(grid[index]);
    }
    if (row < Constants.COLS) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) + Constants.ROWS;
      neigbours.add(grid[index]);
    }
    if (col > 1) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) - 1;
      neigbours.add(grid[index]);
    }
    if (col < Constants.ROWS) {
      num index = ((row - 1) * Constants.ROWS + (col - 1)) + 1;
      neigbours.add(grid[index]);
    }
    List<Node> returnList = [];
    for (Node i in neigbours) {
      if (i.type != NodeType.visited &&
          i.type != NodeType.startVisited &&
          i.type != NodeType.finishVisited) {
        returnList.add(i);
      }
    }
    // print(returnList);
    return returnList;
  }

  static List<Node> getNodesInShortestPath(Node finishNode) {
    List<Node> shortestPath = [];
    var currentNode = finishNode;
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
}
