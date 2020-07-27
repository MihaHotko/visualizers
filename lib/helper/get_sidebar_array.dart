import 'package:visualizer/models/SidebarContent.dart';

class SidebarArray {
  static List<SidebarContent> arr() {
    var returnArr = List<SidebarContent>();
    returnArr.add(
        SidebarContent(order: 0, name: 'Home', icon: 'far fa-home', route: ''));
    returnArr.add(SidebarContent(
        order: 1,
        name: 'Pathfinding',
        icon: 'far fa-wave-square',
        route: 'path'));
    returnArr.add(SidebarContent(
        order: 2, name: 'TBD', icon: 'far fa-question', route: 'tbd'));
    return returnArr;
  }
}
