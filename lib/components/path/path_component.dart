import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:visualizer/algorithms/astar.dart';
import 'package:visualizer/enums/algorithms.dart';
import 'package:visualizer/algorithms/djikstra.dart';
import 'package:visualizer/animation/anime.dart';
import 'package:visualizer/components/path/Node/node_component.dart';
import 'package:visualizer/components/select/select_component.dart';
import 'package:visualizer/enums/node_types.dart';
import 'package:visualizer/models/Grid.dart';
import 'package:visualizer/models/Node.dart';

@Component(
    selector: 'path',
    templateUrl: 'path_component.html',
    directives: [coreDirectives, NodeComponent, SelectComponent],
    styleUrls: ['path_component.css'])
class PathComponent implements OnInit, AfterViewChecked {
  var grid = List<Node>();
  var isMouseDown = false;

  var holdingSpecialNode = null;
  var lastVisitedNodeRow = null;
  var lastVisitedNodeCol = null;
  var algorithmIndex = null;

  var visitedNodes = 0;
  var shortestPathNumber = 0;

  var list = List<String>();

  var aStar = AStar();
  var dijkstra = Dijkstra();

  // LIFECYCLE HOOKS
  @override
  void ngOnInit() {
    grid = Grid.getInitialGrid();
    for (var t in AlgorithmEnum.values) {
      list.add(AlgorithmsHelper.getValue(t));
    }
  }

  @override
  void ngAfterViewChecked() {
    anime(AnimeOptions(targets: '.path-visualizer', opacity: 1, duration: 900));
  }

  // EVENTS
  void mouseDown(num row, num col) {
    isMouseDown = true;
    handleNodes(Grid.getNode(grid, row, col));
  }

  void mouseEnter(num row, num col) {
    if (!isMouseDown) return;
    handleNodes(Grid.getNode(grid, row, col));
  }

  void mouseUp() {
    isMouseDown = false;
  }

  // METHODS

  Object trackByNodeId(_, dynamic o) {
    return o.index;
  }

  void handleNodes(Node node) {
    if (holdingSpecialNode != null &&
        node.type != NodeType.start &&
        node.type != NodeType.finish) {
      grid = Grid.toggleNode(grid, node.row, node.col, holdingSpecialNode);
      holdingSpecialNode = null;
      return;
    }

    if (holdingSpecialNode == null) {
      switch (node.type) {
        case NodeType.start:
          holdingSpecialNode = NodeType.start;
          lastVisitedNodeRow = node.row;
          lastVisitedNodeCol = node.col;
          grid = Grid.toggleNode(grid, node.row, node.col, NodeType.blank);
          break;
        case NodeType.finish:
          holdingSpecialNode = NodeType.finish;
          lastVisitedNodeRow = node.row;
          lastVisitedNodeCol = node.col;
          grid = Grid.toggleNode(grid, node.row, node.col, NodeType.blank);
          break;
        default:
          lastVisitedNodeRow = node.row;
          lastVisitedNodeCol = node.col;
          grid = Grid.toggleNode(
              grid, node.row, node.col, NodeType.wall, NodeType.blank);
          break;
      }
    }
  }

  void visualizeAlgo(AlgorithmEnum type) {
    var startNode =
        grid.firstWhere((element) => element.type == NodeType.start);
    var finishNode =
        grid.firstWhere((element) => element.type == NodeType.finish);
    var visitedNodesInOrder = null;
    var shortestPath = null;

    switch (type) {
      case AlgorithmEnum.Dijkstra:
        visitedNodesInOrder = dijkstra.algorithm(grid, startNode, finishNode);
        shortestPath = dijkstra.getNodesInShortestPath(finishNode);
        break;
      case AlgorithmEnum.AStar:
        visitedNodesInOrder = aStar.algorithm(grid, startNode, finishNode);
        shortestPath = aStar.getNodesInShortestPath(finishNode);
        break;
    }
    visitedNodes = visitedNodesInOrder.length;
    shortestPathNumber = shortestPath.length;
    animateAlgorithm(visitedNodesInOrder, shortestPath);
  }

  void animateAlgorithm(
      List<Node> visitedNodesInOrder, List<Node> shortestPath) {
    for (int i = 0; i < visitedNodesInOrder.length; i++) {
      if (i == visitedNodesInOrder.length - 1) {
        Timer(Duration(milliseconds: 50),
            () => (animateShortestPath(shortestPath)));
      }
      Timer(Duration(milliseconds: 50),
          () => (toggleVisitedClass(visitedNodesInOrder[i])));
    }
  }

  void toggleVisitedClass(Node node) {
    if (node.type != NodeType.startVisited &&
        node.type != NodeType.finishVisited) {
      var classes = querySelector('#node-${node.row}-${node.col}').classes;
      if (classes.contains('node-visited')) {
        classes.remove('node-visited');
      } else {
        classes.add('node-visited');
      }
    }
  }

  void toggleShortestPathClass(Node node) {
    if (node.type != NodeType.startVisited &&
        node.type != NodeType.finishVisited) {
      var classes = querySelector('#node-${node.row}-${node.col}').classes;
      if (classes.contains('node-shortest-path')) {
        classes.remove('node-shortest-path');
      } else {
        classes.add('node-shortest-path');
      }
      if (classes.contains('node-visited')) {
        classes.remove('node-visited');
      }
    }
  }

  animateShortestPath(List<Node> shortestPath) {
    for (int i = 0; i < shortestPath.length; i++) {
      Node node = shortestPath[i];
      Timer(Duration(milliseconds: 10), () => (toggleShortestPathClass(node)));
    }
  }

  void resetBoard() {
    for (Node n in grid) {
      switch (n.type) {
        case NodeType.visited:
          toggleVisitedClass(n);
          break;
        case NodeType.shortestPath:
          toggleShortestPathClass(n);
          break;
        default:
          break;
      }
    }
    visitedNodes = 0;
    shortestPathNumber = 0;
    grid = Grid.getInitialGrid();
  }

  void selectedIndex(num i) {
    algorithmIndex = i;
  }

  void visualizeAlgorithm() {
    if (algorithmIndex == null) return;
    visualize(AlgorithmEnum.values[algorithmIndex]);
  }

  void visualize(AlgorithmEnum valu) {
    visualizeAlgo(valu);
  }
}
