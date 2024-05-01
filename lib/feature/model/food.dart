import 'package:equatable/equatable.dart';

enum FoodCategory {
  fastFood("fast-food"),
  salad("salad"),
  seaFood("seafood");

  final String name;

  const FoodCategory(this.name);
}

class Food extends Equatable {
  final String id;
  final String name;
  final String? url;
  final String description;
  final double price;
  final List<FoodCategory> categories;

  const Food({
    required this.id,
    required this.name,
    this.url,
    required this.description,
    required this.price,
    required this.categories,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    final categories = json['category'];

    return Food(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      categories: categories
          .map<FoodCategory>((category) => _convertToFoodCategory(category))
          .toList(),
    );
  }

  Food copyWith({String? url}) {
    return Food(
      id: id,
      name: name,
      description: description,
      price: price,
      url: url ?? this.url,
      categories: categories,
    );
  }

  @override
  List<Object?> get props => [id];
}

FoodCategory _convertToFoodCategory(String category) {
  Map<String, FoodCategory> categoryMap = {
    'fast-food': FoodCategory.fastFood,
    'salad': FoodCategory.salad,
    'seafood': FoodCategory.seaFood
  };

  return categoryMap[category]!;
}
