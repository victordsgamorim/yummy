import 'package:equatable/equatable.dart';
import 'package:yummy_app/feature/model/food.dart';

class Order extends Equatable {
  final Food food;
  final int quantity;
  final double total;

  const Order({
    required this.food,
    required this.quantity,
    required this.total,
  });

  Order copyWith({int? quantity}) {
    final qnt = quantity ?? this.quantity;
    return Order(food: food, quantity: qnt, total: food.price * qnt);
  }

  @override
  List<Object?> get props => [food, quantity, total];
}
