import 'package:visualizer/algorithms/djikstra.dart';

enum Algorithm { Dijkstra }

class AlgorithmsHelper {
  static String getValue(Algorithm algorithms) {
    switch (algorithms) {
      case Algorithm.Dijkstra:
        return "Dijkstra's algorithm";
        break;
    }
  }
}
