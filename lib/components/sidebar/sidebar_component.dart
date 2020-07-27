import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:visualizer/animation/anime.dart';
import 'package:visualizer/helper/get_sidebar_array.dart';
import 'package:visualizer/models/SidebarContent.dart';

@Component(
    selector: 'sidebar',
    templateUrl: 'sidebar_component.html',
    styleUrls: ['sidebar_component.css'],
    directives: [coreDirectives, routerDirectives])
class SidebarComponent {
  List<SidebarContent> list = SidebarArray.arr();

  void sidebarClick(dynamic event) {
    anime(AnimeOptions(
        targets: '.slider',
        top: event * 60 + 100,
        duration: 600,
        easing: 'easeOutExpo'));
  }
}
