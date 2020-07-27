import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:visualizer/enums/algorithms.dart';
import 'package:visualizer/algorithms/djikstra.dart';
import 'package:visualizer/animation/anime.dart';
import 'package:visualizer/components/path/Node/node_component.dart';
import 'package:visualizer/components/select/select_component.dart';
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
  var isDrag = false;
  var lastVisitedRow = null;
  var lastVisitedCol = null;

  var holdingStart = false;
  var lastVisitedStartRow = null;
  var lastVisitedStartCol = null;
  var lastVisitedFinishRow = null;
  var lastVisitedFinishCol = null;
  var holdingFinish = false;

  var list = List<String>();

  @override
  void ngOnInit() {
    grid = Grid.getInitialGrid();
    for (var t in Algorithm.values) {
      list.add(AlgorithmsHelper.getValue(t));
    }
  }

  Object trackByNodeId(_, dynamic o) {
    return o.index;
  }

  void mouseDown(num row, num col) {
    isMouseDown = true;
    if (Grid.isStart(grid, row, col)) {
      holdingStart = true;
      grid = Grid.toggleStart(grid, row, col);
      lastVisitedStartCol = col;
      lastVisitedStartRow = row;
      return;
    } else if (Grid.isFinish(grid, row, col)) {
      holdingFinish = true;
      grid = Grid.toggleFinish(grid, row, col);
      lastVisitedFinishCol = col;
      lastVisitedFinishRow = row;
      return;
    }
    if (!holdingStart && !holdingFinish) {
      grid = Grid.toggleWall(grid, row, col);
    } else if (holdingStart) {
      grid = Grid.toggleStart(grid, row, col);
      holdingStart = false;
    } else if (holdingFinish) {
      grid = Grid.toggleFinish(grid, row, col);
      holdingFinish = false;
    }
  }

  void mouseEnter(num row, num col) {
    if (!isMouseDown) {
      return;
    } else if (lastVisitedCol == col && lastVisitedRow == row) {
      return;
    }
    isDrag = true;
    lastVisitedCol = col;
    lastVisitedRow = row;
    if (!holdingStart && !holdingFinish) {
      grid = Grid.toggleWall(grid, row, col);
    } else if (holdingStart) {
      grid = Grid.disableStart(grid, lastVisitedStartRow, lastVisitedStartCol);
      grid = Grid.toggleStart(grid, row, col);
      lastVisitedStartCol = col;
      lastVisitedStartRow = row;
    } else if (holdingFinish) {
      grid =
          Grid.disableFinish(grid, lastVisitedFinishRow, lastVisitedFinishCol);
      grid = Grid.toggleFinish(grid, row, col);
      lastVisitedFinishCol = col;
      lastVisitedFinishRow = row;
    }
  }

  void mouseUp() {
    isMouseDown = false;
    if (isDrag) {
      holdingStart = false;
      holdingFinish = false;
      isDrag = false;
    }
  }

  void visualizeDijkstra() {
    List<Node> copyGrid = List<Node>.from(grid);
    var startNode = copyGrid.firstWhere((element) => element.isStart);
    var finishNode = copyGrid.firstWhere((element) => element.isFinish);
    var visitedNodesInOrder =
        Dijkstra.dijkstra(copyGrid, startNode, finishNode);
    var shortestPath = Dijkstra.getNodesInShortestPath(finishNode);
    animateDjikstra(visitedNodesInOrder, shortestPath);
  }

  @override
  void ngAfterViewChecked() {
    anime(AnimeOptions(targets: '.path-visualizer', opacity: 1, duration: 900));
  }

  void animateDjikstra(
      List<Node> visitedNodesInOrder, List<Node> shortestPath) {
    for (int i = 0; i < visitedNodesInOrder.length; i++) {
      if (i == visitedNodesInOrder.length - 1) {
        Timer(Duration(milliseconds: 50),
            () => (animateShortestPath(shortestPath)));
      }
      Timer(Duration(milliseconds: 50),
          () => (switchClass(visitedNodesInOrder[i])));
    }
  }

  void switchClass(Node node) {
    if (!node.isStart && !node.isFinish)
      querySelector('#node-${node.row}-${node.col}').className +=
          ' node-visited';
  }

  void switchClassShortest(Node node) {
    if (!node.isStart && !node.isFinish)
      querySelector('#node-${node.row}-${node.col}').className +=
          'node node-shortest-path';
  }

  animateShortestPath(List<Node> shortestPath) {
    for (int i = 0; i < shortestPath.length; i++) {
      Node node = shortestPath[i];
      Timer(Duration(milliseconds: 10), () => (switchClassShortest(node)));
    }
  }

  void selectedIndex(num i) {
    print(i);
  }
}
