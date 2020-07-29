enum AlgorithmEnum { Dijkstra, AStar }

class AlgorithmsHelper {
  static String getValue(AlgorithmEnum algorithms) {
    switch (algorithms) {
      case AlgorithmEnum.Dijkstra:
        return "Dijkstra's algorithm";
        break;
      case AlgorithmEnum.AStar:
        return "A* algorithm";
        break;
    }
  }
}
