import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yummy_app/core/network/network.dart';
import 'package:yummy_app/feature/blocs/cart/cart_bloc.dart';
import 'package:yummy_app/feature/blocs/food/food_bloc.dart';
import 'package:yummy_app/feature/data/datasource/remote/food_remote_datasource.dart';
import 'package:yummy_app/feature/data/datasource/remote/image_remote_datasource.dart';
import 'package:yummy_app/feature/data/repository/food_repository.dart';

setup() {
  _externalDI();
  _blocDI();
  _repositoryDI();
  _remoteDatasourceDI();
}

_blocDI() {
  GetIt.I.registerFactory(() => FoodBloc(GetIt.I()));
  GetIt.I.registerFactory(() => CartBloc());
}

void _repositoryDI() {
  GetIt.I.registerLazySingleton<FoodRepository>(
      () => FoodRepositoryImpl(GetIt.I(), GetIt.I(), GetIt.I()));
}

void _remoteDatasourceDI() {
  GetIt.I.registerLazySingleton<FoodRemoteDatasource>(
      () => FoodRemoteDatasourceImpl(GetIt.I()));

  GetIt.I.registerLazySingleton<ImageRemoteDatasource>(
      () => ImageRemoteDatasourceImpl(GetIt.I()));
}

void _externalDI() async {
  GetIt.I.registerLazySingleton(() => Connectivity());
  GetIt.I.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(GetIt.I()));

  GetIt.I.registerLazySingleton(() => http.Client());
}
