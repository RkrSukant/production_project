import 'package:get_it/get_it.dart';
import 'package:production_project/feature/categories/data/categories_repository.dart';
import 'package:production_project/feature/categories/data/categories_repository_impl.dart';
import 'package:production_project/feature/categories/data/local/categories_local.dart';
import 'package:production_project/feature/categories/data/local/categories_local_impl.dart';
import 'package:production_project/feature/categories/data/remote/categories_remote.dart';
import 'package:production_project/feature/categories/data/remote/categories_remote_impl.dart';
import 'package:production_project/feature/categories/screens/categories_viewmodel.dart';
import 'package:production_project/feature/home/data/home_repository.dart';
import 'package:production_project/feature/home/data/home_repository_impl.dart';
import 'package:production_project/feature/home/data/local/home_local.dart';
import 'package:production_project/feature/home/data/local/home_local_impl.dart';
import 'package:production_project/feature/home/data/remote/home_remote.dart';
import 'package:production_project/feature/home/data/remote/home_remote_impl.dart';
import 'package:production_project/feature/home/screens/home_viewmodel.dart';
import 'package:production_project/feature/product_display/data/local/product_detail_local.dart';
import 'package:production_project/feature/product_display/data/local/product_detail_local_impl.dart';
import 'package:production_project/feature/product_display/data/product_detail_repository.dart';
import 'package:production_project/feature/product_display/data/product_detail_repository_impl.dart';
import 'package:production_project/feature/product_display/data/remote/product_detail_remote.dart';
import 'package:production_project/feature/product_display/data/remote/product_detail_remote_impl.dart';
import 'package:production_project/feature/product_display/screens/product_detail_viewmodel.dart';
import 'package:production_project/feature/rooms/data/local/rooms_local.dart';
import 'package:production_project/feature/rooms/data/local/rooms_local_impl.dart';
import 'package:production_project/feature/rooms/data/remote/rooms_remote.dart';
import 'package:production_project/feature/rooms/data/remote/rooms_remote_impl.dart';
import 'package:production_project/feature/rooms/data/rooms_repository.dart';
import 'package:production_project/feature/rooms/data/rooms_repository_impl.dart';
import 'package:production_project/feature/rooms/screens/rooms_viewmodel.dart';
import 'package:production_project/feature/search/data/local/search_local.dart';
import 'package:production_project/feature/search/data/local/search_local_impl.dart';
import 'package:production_project/feature/search/data/remote/search_remote.dart';
import 'package:production_project/feature/search/data/remote/search_remote_impl.dart';
import 'package:production_project/feature/search/data/search_repository.dart';
import 'package:production_project/feature/search/data/search_repository_impl.dart';
import 'package:production_project/feature/search/screens/search_viewmodel.dart';
import 'package:production_project/remote/http_client.dart';

final GetIt locator = GetIt.instance;

Future setUpServiceLocator() async {
  //for api
  locator.registerLazySingleton(() => ApiClient());

  //home
  locator.registerLazySingleton<HomeLocal>(() => HomeLocalImpl());
  locator.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());

  //categories
  locator.registerLazySingleton<CategoriesLocal>(() => CategoriesLocalImpl());
  locator.registerLazySingleton<CategoriesRemote>(() => CategoriesRemoteImpl());
  locator.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl());
  locator.registerFactory<CategoriesViewModel>(() => CategoriesViewModel());

  //rooms
  locator.registerLazySingleton<RoomsLocal>(() => RoomsLocalImpl());
  locator.registerLazySingleton<RoomsRemote>(() => RoomsRemoteImpl());
  locator.registerLazySingleton<RoomsRepository>(() => RoomsRepositoryImpl());
  locator.registerFactory<RoomsViewModel>(() => RoomsViewModel());

  //search
  locator.registerLazySingleton<SearchLocal>(() => SearchLocalImpl());
  locator.registerLazySingleton<SearchRemote>(() => SearchRemoteImpl());
  locator.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl());
  locator.registerFactory<SearchViewModel>(() => SearchViewModel());

  //product display
  locator.registerLazySingleton<ProductDetailLocal>(
      () => ProductDetailLocalImpl());
  locator.registerLazySingleton<ProductDetailRemote>(
      () => ProductDetailRemoteImpl());
  locator.registerLazySingleton<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl());
  locator
      .registerFactory<ProductDetailViewModel>(() => ProductDetailViewModel());
}
