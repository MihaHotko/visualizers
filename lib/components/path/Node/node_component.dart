import 'package:angular/angular.dart';

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
  bool isStart;
  @Input()
  bool isFinish;
  @Input()
  bool isWall;
  @Input()
  bool mouseDown;

  String getExtraClassName() {
    return isFinish
        ? 'node-finish'
        : isStart ? 'node-start' : isWall ? 'node-wall' : '';
  }
}
