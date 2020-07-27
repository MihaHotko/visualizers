import 'package:angular/angular.dart';
import 'package:visualizer/enums/node_types.dart';

@Component(
    selector: 'node',
    templateUrl: 'node.html',
    styleUrls: ['node.css'],
    directives: [coreDirectives])
class NodeComponent {
  @Input()
  String row;
  @Input()
  String col;
  @Input()
  NodeType nodeType;

  String getExtraClassName() {
    switch (nodeType) {
      case NodeType.start:
        return 'node-start';
        break;
      case NodeType.startVisited:
        return 'node-start';
        break;
      case NodeType.finish:
        return 'node-finish';
        break;
      case NodeType.finishVisited:
        return 'node-finish';
        break;
      case NodeType.wall:
        return 'node-wall';
        break;
      default:
        return '';
        break;
    }
  }
}
