import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/home/data/home_repository.dart';
import 'package:production_project/feature/home/data/local/home_local.dart';
import 'package:production_project/feature/home/data/remote/home_remote.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemote remote = locator<HomeRemote>();
  final HomeLocal local = locator<HomeLocal>();

}