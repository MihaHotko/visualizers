import 'package:angular_router/angular_router.dart';

import 'route_paths.template.dart';
import '../components/path/path_component.template.dart' as path_template;
import '../components/welcome/welcome_component.template.dart'
    as welcome_template;

export 'route_paths.template.dart';

class Routes {
  static final path = RouteDefinition(
    routePath: RoutePaths.path,
    component: path_template.PathComponentNgFactory,
  );

  static final welcome = RouteDefinition(
    routePath: RoutePaths.welcome,
    component: welcome_template.WelcomeComponentNgFactory,
  );

  static final all = <RouteDefinition>[path, welcome];
}
