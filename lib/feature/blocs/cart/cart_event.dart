part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AddOrderToCartEvent extends CartEvent {
  final Order order;

  AddOrderToCartEvent(this.order);

  @override
  List<Object?> get props => [order];
}

final class UpdateOrderEvent extends CartEvent {
  final Order order;
  final int increment;

  UpdateOrderEvent({required this.order, required this.increment});

  @override
  List<Object?> get props => [order, increment];
}

final class RemoveOrdersEvent extends CartEvent {}

final class AddPlacedOrderEvent extends CartEvent {
  final PlacedOrder placedOrder;

  AddPlacedOrderEvent(this.placedOrder);

  @override
  List<Object?> get props => [placedOrder];
}
