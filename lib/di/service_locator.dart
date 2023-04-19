import 'package:get_it/get_it.dart';
import 'package:production_project/feature/home_screen/data/home_repository.dart';
import 'package:production_project/feature/home_screen/data/home_repository_impl.dart';
import 'package:production_project/feature/home_screen/data/local/home_local.dart';
import 'package:production_project/feature/home_screen/data/local/home_local_impl.dart';
import 'package:production_project/feature/home_screen/data/remote/home_remote.dart';
import 'package:production_project/feature/home_screen/data/remote/home_remote_impl.dart';
import 'package:production_project/feature/home_screen/screens/home_viewmodel.dart';

final GetIt locator =GetIt.instance;

Future setUpServiceLocator() async {

  //home
  locator.registerLazySingleton<HomeLocal>(() => HomeLocalImpl());
  locator.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());

}