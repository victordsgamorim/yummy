part of 'cart_bloc.dart';

@immutable
sealed class CartState {
  final List<Order> orders;
  final List<PlacedOrder> placedOrders;

  const CartState({required this.orders, required this.placedOrders});
}

final class CartEmpty extends CartState with EquatableMixin {
  CartEmpty({required super.placedOrders}) : super(orders: []);

  @override
  List<Object?> get props => [orders];
}

final class CartSuccess extends CartState {
  const CartSuccess({required super.orders, required super.placedOrders});
}
