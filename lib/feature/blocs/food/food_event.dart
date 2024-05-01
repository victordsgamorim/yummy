part of 'food_bloc.dart';

@immutable
sealed class FoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadAllFoodEvent extends FoodEvent {}

final class FilterFoodEvent extends FoodEvent {
  final FoodCategory category;

  FilterFoodEvent(this.category);

  @override
  List<Object?> get props => [category];
}
