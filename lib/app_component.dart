import 'dart:html';

import 'package:angular/angular.dart';
import 'package:visualizer/router/route_paths.dart';
import 'package:visualizer/router/routes.dart';
import 'package:angular_router/angular_router.dart';

import 'components/sidebar/sidebar_component.dart';

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [routerDirectives, SidebarComponent],
    exports: [RoutePaths, Routes])
class AppComponent implements OnInit {
  var name = 'Angular';

  @override
  void ngOnInit() {
    querySelector('body').style.backgroundColor = 'white';
  }
}
