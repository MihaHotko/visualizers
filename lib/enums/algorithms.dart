enum AlgorithmEnum { Dijkstra, AStar, DFS }

class AlgorithmsHelper {
  static String getValue(AlgorithmEnum algorithms) {
    switch (algorithms) {
      case AlgorithmEnum.Dijkstra:
        return "Dijkstra's algorithm";
        break;
      case AlgorithmEnum.AStar:
        return "A* algorithm";
        break;
      case AlgorithmEnum.DFS:
        return "Depth First Search";
        break;
      default:
        return '';
        break;
    }
  }
}
