import 'package:dartz/dartz.dart';
import 'package:yummy_app/core/error/exceptions.dart';
import 'package:yummy_app/core/error/failures.dart';
import 'package:yummy_app/core/utils/constants/messages.dart';

typedef AsyncEitherCallback<T> = Future<Either<Failure, T>> Function();

mixin RepositoryCallbackMixin {
  Future<Either<Failure, T>> executeWithNetworkCheck<T>({
    bool isConnected = true,
    required AsyncEitherCallback<T> callback,
  }) async {
    if (isConnected) {
      try {
        return await callback();
      } on AppException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }

    return const Left(InternetFailure(message: noConnection));
  }
}
