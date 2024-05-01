import 'package:equatable/equatable.dart';
import 'package:yummy_app/feature/model/order.dart';

class DeliveryType {
  final String name;
  final String expectedTime;

  DeliveryType._({required this.name, required this.expectedTime});

  static DeliveryType standard =
      DeliveryType._(name: 'Standard Delivery', expectedTime: '35 - 55min');
  static DeliveryType priority =
      DeliveryType._(name: 'Priority Delivery', expectedTime: '25 - 30min');

  static List<DeliveryType> get values => [standard, priority];
}

class PlacedOrder extends Equatable {
  final List<Order> orders;
  final DeliveryType deliveryType;
  final double total;

  const PlacedOrder({
    required this.orders,
    required this.deliveryType,
    required this.total,
  });

  @override
  List<Object?> get props => [orders, deliveryType, total];
}
