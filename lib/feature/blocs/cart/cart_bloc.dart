import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yummy_app/core/utils/extensions/iterable_extension.dart';
import 'package:yummy_app/feature/model/order.dart';
import 'package:yummy_app/feature/model/placed_order.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty(placedOrders: [])) {
    on<AddOrderToCartEvent>((event, emit) {
      final order = event.order;
      state.orders.add(order);
      emit(CartSuccess(orders: state.orders, placedOrders: state.placedOrders));
    });

    on<UpdateOrderEvent>((event, emit) {
      final index =
          state.orders.indexWhere((order) => order.food == event.order.food);

      if (index > -1) {
        state.orders[index] = event.order.copyWith(quantity: event.increment);
      }
      emit(CartSuccess(orders: state.orders, placedOrders: state.placedOrders));
    });

    on<RemoveOrdersEvent>((event, emit) {
      emit(CartEmpty(placedOrders: state.placedOrders));
    });

    on<AddPlacedOrderEvent>((event, emit) {
      state.placedOrders.add(event.placedOrder);
      emit(CartEmpty(placedOrders: state.placedOrders));
    });
  }
}
