import 'package:flutter/foundation.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/home/data/home_repository.dart';

class HomeViewModel extends ChangeNotifier{
  final HomeRepository repository = locator<HomeRepository>();
}