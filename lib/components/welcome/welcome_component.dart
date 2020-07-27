import 'package:angular/angular.dart';
import 'package:visualizer/animation/anime.dart';

@Component(
  selector: 'welcome',
  templateUrl: 'welcome_component.html',
  styleUrls: ['welcome_component.css'],
)
class WelcomeComponent implements AfterViewChecked {
  @override
  void ngAfterViewChecked() {
    print('stsart');
    anime(AnimeOptions(
        targets: '.text-container',
        opacity: 1,
        duration: 1000,
        easing: 'easeOutExpo'));
  }
}
