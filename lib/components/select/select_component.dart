import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Component(
    selector: 'my-select',
    templateUrl: 'select_component.html',
    directives: [coreDirectives],
    styleUrls: ['select_component.css'])
class SelectComponent {
  @Input()
  var inputList;
  @Output()
  Stream<num> get getSelectedIndex => _getSelectedIndex.stream;

  final _getSelectedIndex = StreamController<num>();

  void toggleSelect() {
    var select = querySelector('.option-container');
    var icon = querySelector('.chevron-select');
    select.classes.contains('active')
        ? select.classes.remove('active')
        : select.classes.add('active');
    select.classes.contains('active')
        ? icon.classes.add('active')
        : icon.classes.remove('active');
  }

  void optionClick(num i) {
    var selectText = querySelector('.select-category');
    selectText.text = inputList[i];
    toggleSelect();
    _getSelectedIndex.add(i);
  }
}
