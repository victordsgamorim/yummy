part of 'food_bloc.dart';

@immutable
sealed class FoodState {
  final List<Food> foods;

  const FoodState({required this.foods});
}

final class FoodEmpty extends FoodState with EquatableMixin {
  FoodEmpty() : super(foods: []);

  @override
  List<Object?> get props => [foods];
}

final class FoodLoading extends FoodState with EquatableMixin {
  FoodLoading() : super(foods: []);

  @override
  List<Object?> get props => [foods];
}

final class FoodSuccess extends FoodState {
  const FoodSuccess({required super.foods});
}

final class FoodError extends FoodState with EquatableMixin {
  final String message;

  const FoodError({required this.message, required super.foods});

  @override
  List<Object?> get props => [message, foods];
}
