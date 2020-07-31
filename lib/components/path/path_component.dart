import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:visualizer/algorithms/astar.dart';
import 'package:visualizer/algorithms/bfs.dart';
import 'package:visualizer/algorithms/dfs.dart';
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

  var previousAnimatedNode = null;

  var hasStarted = false;

  var visitedNodes = 0;
  var shortestPathNumber = 0;

  var list = List<String>();

  var aStar = AStar();
  var dijkstra = Dijkstra();
  var dfs = DFS();
  var bfs = BFS();

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
        animateAlgorithm(visitedNodesInOrder, shortestPath);
        break;
      case AlgorithmEnum.AStar:
        visitedNodesInOrder = aStar.algorithm(grid, startNode, finishNode);
        shortestPath = aStar.getNodesInShortestPath(finishNode);
        animateAlgorithm(visitedNodesInOrder, shortestPath);
        break;
      case AlgorithmEnum.DFS:
        visitedNodesInOrder = dfs.algorithm(grid, startNode, finishNode);
        shortestPath = dfs.getNodesInShortestPath(finishNode);
        animateAlgorithm(visitedNodesInOrder, shortestPath);
        break;
      case AlgorithmEnum.BFS:
        visitedNodesInOrder = bfs.algorithm(grid, startNode, finishNode);
        shortestPath = bfs.getNodesInShortestPath(finishNode);
        animateAlgorithm(visitedNodesInOrder, shortestPath);
        break;
    }
    visitedNodes = visitedNodesInOrder.length;
    shortestPathNumber = shortestPath.length;
  }

  void animateAlgorithm(
      List<Node> visitedNodesInOrder, List<Node> shortestPath) {
    for (int i = 0; i < visitedNodesInOrder.length; i++) {
      if (i == visitedNodesInOrder.length - 1) {
        Timer(Duration(milliseconds: 100),
            () => (animateShortestPath(shortestPath)));
      }
      Timer(Duration(milliseconds: 100),
          () => (toggleVisitedClass(visitedNodesInOrder[i])));
    }
    hasStarted = false;
  }

  void toggleVisitedClass(Node node) {
    if (node.type != NodeType.startVisited &&
        node.type != NodeType.finishVisited) {
      var classes = querySelector('#node-${node.row}-${node.col}').classes;
      if (previousAnimatedNode != null) {
        var previousclasses = querySelector(
                '#node-${previousAnimatedNode.row}-${previousAnimatedNode.col}')
            .classes;
        previousclasses.remove('node-current-visited');
        classes.add('node-visited');
      }
      if (!classes.contains('node-current-visited')) {
        classes.add('node-current-visited');
      }
    }
    if (node.type == NodeType.finishVisited) {
      var previousclasses = querySelector(
              '#node-${previousAnimatedNode.row}-${previousAnimatedNode.col}')
          .classes;
      previousclasses.remove('node-current-visited');
      previousclasses.add('node-visited');
    }
    previousAnimatedNode = node;
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
    disableButton('.btn-secondary', false);
  }

  void resetBoard() {
    for (Node n in grid) {
      var classes = querySelector('#node-${n.row}-${n.col}').classes;
      switch (n.type) {
        case NodeType.visited:
          classes.remove('node-visited');
          break;
        case NodeType.shortestPath:
          classes.remove('node-shortest-path');
          break;
        default:
          break;
      }
    }
    visitedNodes = 0;
    shortestPathNumber = 0;
    grid = Grid.getInitialGrid();
    disableButton('.btn-primary', false);
  }

  void selectedIndex(num i) {
    algorithmIndex = i;
  }

  void visualizeAlgorithm() {
    if (algorithmIndex == null) return;
    visualize(AlgorithmEnum.values[algorithmIndex]);
  }

  void visualize(AlgorithmEnum valu) {
    disableButton('.btn-primary', true);
    disableButton('.btn-secondary', true);
    visualizeAlgo(valu);
  }

  void disableButton(String clas, bool isDisabled) {
    var btn = querySelector(clas);
    if (isDisabled) btn.setAttribute('disabled', isDisabled.toString());
    if (!isDisabled) btn.removeAttribute('disabled');
  }
}
