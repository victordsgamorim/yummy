import 'package:dartz/dartz.dart';
import 'package:yummy_app/core/error/failures.dart';
import 'package:yummy_app/core/network/network.dart';
import 'package:yummy_app/core/utils/mixins/repository_callback_mixin.dart';
import 'package:yummy_app/feature/data/datasource/remote/food_remote_datasource.dart';
import 'package:yummy_app/feature/data/datasource/remote/image_remote_datasource.dart';
import 'package:yummy_app/feature/model/food.dart';

abstract interface class FoodRepository {
  Future<Either<Failure, List<Food>>> getAll();
}

final class FoodRepositoryImpl
    with RepositoryCallbackMixin
    implements FoodRepository {
  final NetworkInfo _networkInfo;
  final FoodRemoteDatasource _foodRemoteDatasource;
  final ImageRemoteDatasource _imageRemoteDatasource;

  const FoodRepositoryImpl(
    this._networkInfo,
    this._foodRemoteDatasource,
    this._imageRemoteDatasource,
  );

  @override
  Future<Either<Failure, List<Food>>> getAll() async {
    return executeWithNetworkCheck<List<Food>>(
        isConnected: await _networkInfo.isConnected,
        callback: () async {
          final foods = await _foodRemoteDatasource.getAll();

          for (int i = 0; i < foods.length; i++) {
            final food = foods[i];
            final image =
                await _imageRemoteDatasource.searchForImage(food.name);
            foods[i] = food.copyWith(url: image);
          }
          return Right(foods);
        });
  }
}
