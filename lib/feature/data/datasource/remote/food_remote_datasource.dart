import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:yummy_app/core/error/exceptions.dart';
import 'package:yummy_app/core/utils/constants/api.dart';
import 'package:yummy_app/core/utils/constants/messages.dart';
import 'package:yummy_app/feature/model/food.dart';
import 'package:yummy_app/gen/assets.gen.dart';

abstract interface class FoodRemoteDatasource {
  Future<List<Food>> getAll();
}

final class FoodRemoteDatasourceImpl implements FoodRemoteDatasource {
  final http.Client _client;

  const FoodRemoteDatasourceImpl(this._client);

  @override
  Future<List<Food>> getAll() async {
    List<Food> foods = [];
    try {
      final response = await _client.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        foods = data.map<Food>((food) => Food.fromJson(food)).toList();
      }
    } catch (e) {
      final response = await rootBundle.loadString(Assets.fixture.foodFixture);
      final data = json.decode(response);
      foods = data['foods'].map<Food>((food) => Food.fromJson(food)).toList();
    }

    return foods;
    throw const ServerException(noServerConnection);
  }
}
